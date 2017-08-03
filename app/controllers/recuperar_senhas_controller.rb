class RecuperarSenhasController < ApplicationController
  layout "sessions"

  skip_before_action :login_obrigatorio, :set_hosts
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @cliente = Cliente.find_by(email: params[:recuperar_password][:email].downcase)
    if @cliente
      @cliente.create_reset_digest
      @cliente.enviar_email_recuperacao
      flash[:info] = "Foi enviado um email com instruções para recuperar sua senha."
      redirect_to login_url
    else
      flash.now[:danger] = "O endereço de email que introduziu não foi encontrado."
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:cliente][:password].empty?                  # Case (3)
      @cliente.errors.add(:password, "não pode estar em branco")
      render 'edit'
    elsif @cliente.update_attributes(cliente_params)          # Case (4)
      log_in @cliente
      flash[:success] = "A sua senha foi alterada."
      redirect_to root_url
    else
      render 'edit'                                     # Case (2)
    end
  end

  private

    def cliente_params
      params.require(:cliente).permit(:password, :password_confirmation)
    end


    def get_user
      @cliente = Cliente.find_by(email: params[:email])
    end

    def valid_user
      unless (@cliente && @cliente.authenticated?(:reset, params[:id]))
        redirect_to login_url
      end
    end

    def check_expiration
      if @cliente.recuperacao_expirada?
        flash[:danger] = "O seu pedido de recuperação expirou."
        redirect_to new_recuperar_password_url
      end
    end
end
