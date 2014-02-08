class User < ActiveRecord::Base

  attr_accessor :name, :email, :citizen_number   #TODO Id should be the citizen number (Long)

  validates(:name, presence: true)
  validates(:email, presence: true)
  validates(:citizen_number, presence: true)

end
