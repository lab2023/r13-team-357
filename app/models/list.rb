class List < ActiveRecord::Base
  belongs_to :project
  has_many :cards

  validates :name, presence: true, uniqueness: {scope: :project_id}
  validates :sort, uniqueness: {scope: :project_id}

  before_create :set_sort
  private
  def set_sort
    last_list = self.project.lists.order('sort ASC').last
    self.sort = last_list.present? ? last_list.sort + 1 : 1
  end

end
