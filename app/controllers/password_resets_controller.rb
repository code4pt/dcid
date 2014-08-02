class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      flash.now[:success] = 'Enviado email com as instruções para recuperar a sua palavra-chave.'
      render root_url
    else
      flash.now[:error] = 'De certeza que usou esse email?'
      render 'new'
    end
  end

end
