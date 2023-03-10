class Project < ApplicationRecord
  validates :title, :description, presence: true
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments
  belongs_to :admin_user
  has_many :project_activities,dependent: :destroy

  enum status: {
  unassigned: 'unassigned',
  pending: 'pending',
  accepted: 'accepted',
  started: 'started',
  completed: 'completed'
}, _suffix: true
end
