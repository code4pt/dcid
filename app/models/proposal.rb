class Proposal < ActiveRecord::Base

  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 80 }
  validates :problem, presence: true, length: { maximum: 400 }
  validates :solution, presence: true, length: { maximum: 700 }

  default_scope -> { order('created_at DESC') }

end
