class List < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true, uniqueness: {scope: :project_id}

end
