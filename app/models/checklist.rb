class Checklist < ActiveRecord::Base
  belongs_to :card
  validates_presence_of :title
end
