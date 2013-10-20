class Document < ActiveRecord::Base
  belongs_to :card
  belongs_to :user

  has_attached_file :file
      #:storage => :s3,
      #:s3_protocol => 'http',
      #:s3_host_name => AWS_CONFIG["end_point"],
      #:s3_credentials => "#{Rails.root}/config/application.yml",
      #:url => ":s3_alias_url",
      #:s3_host_alias => AWS_CONFIG["aws_raw_url"],
      #:path => "files/:id/:style/:file_name.:extension"
  validates_attachment_size :file, less_than: 3.megabytes

  Paperclip.interpolates :file_name do |attachment, style|
    attachment.instance.normalized_file_name
  end

  def normalized_file_name
    "#{card.id}-#{file_file_name.split('.')[0]}-#{id}"
  end
end
