class Document < ActiveRecord::Base
  belongs_to :card
  belongs_to :user

  has_attached_file :file
  validates_attachment_size :file, less_than: 3.megabytes
end
