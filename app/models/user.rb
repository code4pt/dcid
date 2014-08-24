class User < ActiveRecord::Base

  has_secure_password
  has_many :proposals, dependent: :destroy
  attr_accessor :control_numbers
  acts_as_voter  # thumbs_up gem

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_CITIZEN_NUMBER_REGEX = /[1-9]\d{7,}/  #TODO what is the portuguese regex for BI/CC number?
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }
  validates :citizen_number, presence: true, format: { with: VALID_CITIZEN_NUMBER_REGEX }, uniqueness: true
  validates_presence_of :control_numbers
  #validate :is_authentic_citizen, :before => :save

  before_save { self.email = email.downcase; self.political_party = political_party.delete(' ').upcase }
  before_create :create_remember_token

  default_scope -> { order('created_at DESC') }


  def first_name
    if is_name_public
      self.name.split(' ').first
    else 'Anónimo'
    end
  end

  def last_name
    if is_name_public
      self.name.split(' ').last
    else ''
    end
  end

  def short_name
    if(first_name != last_name)
      first_name + ' ' + last_name
    else
      first_name
    end
  end

  def welcome_name
    self.name.split(' ').first # ignores is_public_name
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  private

#   def is_authentic_citizen
#     true
#      controls_numbers = control_numbers.strip.delete(' ')
#      if (self.control_numbers.length) == 1    # BI: Digit
#        citizen_number_digits = citizen_number.split('').to_a
#        control_numbers_digit = control_numbers.to_a[0].to_i
#
#        total = 0
#        max = citizen_number_digits.length + control_numbers.length
#        for i in 2..max
#            total += i * citizen_number_digits[max-i].to_i
#        end
#        total += control_numbers.to_a[0].to_i;
#
#        if total % 11 != 0  # total must be a multiple of 11
#          errors.add(:user, 'O número de controlo não é válido para o número de cartão.')
#        end
#
#      elsif (self.control_numbers.length) == 4 # CC: DigitLetterLetterDigit
#        puts "TODO"
#
#      else
#        errors.add(:user, 'O número de controlo não está no formato esperado.')
#      end
#   end

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
