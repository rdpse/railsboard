class SessionsController < ApplicationController
  skip_before_action :login_obrigatorio, :set_hosts
  layout "sessions"

  def new
  end

  def create
    cliente = Cliente.find_by(email: params[:session][:email].downcase)
    if cliente && cliente.authenticate(params[:session][:password])
      log_in cliente
      remember cliente
      redirect_to root_url
    else
      #error
      flash.now[:danger] = 'Email e/ou password inválidos.'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'Até à próxima.'
    redirect_to login_url
  end
end
