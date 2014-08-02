class PasswordResetsController < ApplicationController
  def new
  end

  def index
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Enviado email com as instruções para recuperar a sua palavra-chave."
  end
end
