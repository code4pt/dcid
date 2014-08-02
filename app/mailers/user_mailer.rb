class UserMailer < ActionMailer::Base
  default from: "no-reply@dcid.org"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Recuperação de palavra-chave"
  end
end
