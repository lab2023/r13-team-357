AWS_CONFIG = YAML.load_file("#{Rails.root}/config/application.yml")[Rails.env]
AWS.config({
                               :access_key_id => AWS_CONFIG["access_key_id"],
                               :secret_access_key => AWS_CONFIG["secret_access_key"],
                           })
S3_BUCKET_OBJECT = AWS::S3.new(:s3_endpoint => AWS_CONFIG["end_point"]).buckets[AWS_CONFIG["bucket"]]