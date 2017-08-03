class ClientesController < ApplicationController

  def edit
    @cliente = current_user
  end

  def update
    @cliente = current_user 

    if @cliente.update_attributes(cliente_params)
      flash[:success] = "Os seus dados foram atualizados."
      redirect_to perfil_editar_url
    else
      flash.now[:danger] = "Não foi possível atualizar os seus dados."
      render 'edit'
    end
  end

  private

    def cliente_params
      params.require(:cliente).permit(:nome, :email, :password, :password_confirmation, :moeda)
    end

end
