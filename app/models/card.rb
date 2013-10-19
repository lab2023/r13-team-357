class Card < ActiveRecord::Base
  belongs_to :list
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :assigned, class_name: 'User', foreign_key: 'assignment_id'

  validates :title, presence: true
  validates :list_id, presence: true

end
