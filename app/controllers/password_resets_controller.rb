class PasswordResetsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:success] = "Enviado email com as instruções para recuperar a sua palavra-chave."
    redirect_to root_url
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:alert] = "Expirou o tempo para recuperar a palavra-chave. Recomece o processo."
      redirect_to new_password_reset_path
    elsif @user.update_attributes(params.require(:user).permit(:password, :password_confirmation).merge(password_reset_token: nil))
      flash[:success] = "A palavra-chave foi alterada."
      redirect_to sign_in(@user)
    else
      render :edit
    end
  end

end
