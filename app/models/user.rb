class User < ActiveRecord::Base

  has_secure_password
  has_many :proposals, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_CITIZEN_NUMBER_REGEX = /[1-9]\d{7,}/  #TODO what is the portuguese regex for BI/CC number?
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :citizen_number, presence: true, format: { with: VALID_CITIZEN_NUMBER_REGEX }, uniqueness: true
  validates :password, length: { minimum: 6 }

  before_save { self.email = email.downcase }
  before_create :create_remember_token


  def first_name
    self.name.split(' ').first
  end

  def last_name
    self.name.split(' ').last
  end

  def short_name
    first_name + ' ' + last_name
  end


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
