class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash.now[:success] = "Enviado email com as instruções para recuperar a sua palavra-chave."
    render root_url
    #redirect_to root_url, :notice => "Enviado email com as instruções para recuperar a sua palavra-chave."
  end

end
