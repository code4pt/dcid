class User < ActiveRecord::Base

  #attr_accessor :name, :email, :citizen_number, :password, :password_confirmation
  attr_accessor :name, :email, :password, :password_confirmation

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_CITIZEN_NUMBER_REGEX = /[1-9]\d{7,}/  #TODO what is the portuguese regex for BI/CC number?
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :citizen_number, presence: true, format: { with: VALID_CITIZEN_NUMBER_REGEX }, uniqueness: true

  before_save { lowercase_email() }

  def lowercase_email() 
    self.email = email.downcase
  end

end
