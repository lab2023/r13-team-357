class Card < ActiveRecord::Base
  belongs_to :list
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :assigned, class_name: 'User', foreign_key: 'assignment_id'
  has_many :comments
  has_many :checklists

  validates :title, presence: true
  validates :list_id, presence: true
  validates :sort, uniqueness: {scope: :list_id}

  before_create :set_sort

  validates_inclusion_of :assignment_id, :in => lambda { |card| card.list.project.users.map(&:id) }, allow_nil: true

  private
  def set_sort
    last_card = self.list.cards.order('sort ASC').last
    self.sort = last_card.present? ? last_card.sort + 1 : 1
  end

end
