class Comment < ActiveRecord::Base
  belongs_to :card
  belongs_to :user

  validates_presence_of :body
end
