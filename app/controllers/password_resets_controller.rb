class PasswordResetsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    #flash.now[:success] = "Enviado email com as instruções para recuperar a sua palavra-chave."
    #render root_url
    redirect_to root_url, :notice => "Enviado email com as instruções para recuperar a sua palavra-chave."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Expirou o tempo para recuperar a palavra-chave. Recomece o processo."
    elsif @user.update_attributes(params[:user])
      redirect_to sign_in, :notice => "A palavra-chave foi alterada."
    else
      render :edit
    end
  end

end
