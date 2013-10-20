class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email
  #has_many :projects, foreign_key: 'owner_id'
  has_many :own_projects, class_name: 'Project', foreign_key: 'owner_id'
  has_and_belongs_to_many :projects
  has_many :comments
  has_many :documents

  has_one :profile
  delegate :name, :name=, :github, :github=, :stackoverflow, :stackoverflow=, :bio, :bio=, :facebook, :facebook=, :twitter, :twitter=, :blog, :blog=, to: :profile

  has_many :domains

  accepts_nested_attributes_for :profile
end
