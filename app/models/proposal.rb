class Proposal < ActiveRecord::Base

  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true

end
