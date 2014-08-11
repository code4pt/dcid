# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Dcid::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'dialexnunes',
  :password => '8v9Bn%xBywh60!1v',
  :domain => 'dcid.org',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
