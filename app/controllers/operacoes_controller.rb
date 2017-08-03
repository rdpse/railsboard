class OperacoesController < ApplicationController
  include OperacoesHelper
  before_action :get_host
  respond_to? :html, :js

  def get_host
    @host = current_user.hosts.find_by(hostname: params[:hostname])
  end

  def reiniciar
    unless @host.reiniciando 
      if conectavel?(@host.ipv4)
        soft_reboot(@host.ipv4)
        VigiarServidorJob.set(wait: 5.minutes).perform_later(@host)
      else
        hard_reboot(@host)
      end
      @host.lives(false)  # Host went offline
      @host.a_reiniciar(true)

      flash[:success] = 'O servidor irá reiniciar. Esta operação pode demorar até 3 minutos a concluir.'
    else
      flash[:info] = 'O servidor já está a reiniciar.'
    end
    redirect_to servidores_url
  end
end
