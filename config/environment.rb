# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Dcid::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV["MAILER_USER"],
  :password => ENV["MAILER_PASS"],
  :domain => ENV["APP_ROOT_DOMAIN"],
  :address => ENV["MAILER_ADDRESS"],
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
