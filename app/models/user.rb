class User < ActiveRecord::Base
  attr_accessor :name, :email, :citizen_number   #TODO Id should be the citizen number (Long)

end
