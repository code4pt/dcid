class User < ActiveRecord::Base

  attr_accessor :name, :email, :citizen_number   #TODO Id should be the citizen number (Long)

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_CITIZEN_NUMBER_REGEX = /[1-9]\d{7,}/
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :citizen_number, presence: true, format: { with: VALID_CITIZEN_NUMBER_REGEX }

end
