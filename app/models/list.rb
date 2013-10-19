class List < ActiveRecord::Base
  belongs_to :project
  has_many :cards

  validates :name, presence: true, uniqueness: {scope: :project_id}

end
