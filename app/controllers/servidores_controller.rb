class ServidoresController < ApplicationController
  respond_to? :js, :html

  before_action :set_host, except: [:index]

  def index
    @cliente = current_user
    if @cliente.hosts.first.present?
      @host = current_user.hosts.first.hostname
      redirect_to servidor_url(@host)
    else
      @hosts = @cliente.hosts.all
    end
  end

  def show
  end

  def reiniciar
    unless @host.reiniciando 
      if @host.conectavel?
        @host.soft_reboot
        VigiarServidorJob.set(wait: 5.minutes).perform_later(@host)
      else
        @host.hard_reboot
      end
      @host.lives(false)  # Host went offline
      @host.a_reiniciar(true)

      flash.now[:success] = 'O servidor irá reiniciar. Esta operação pode demorar até 3 minutos a concluir.'
    else
      flash.now[:info] = 'O servidor já está a reiniciar.'
    end
  end

  def limpar_cache
    # TODO: handle response and report accordingly
    @host.limpar_cache_cloudflare
    flash.now[:success] = 'Esvaziando a cache. Por favor aguarde'
  end

# def operacoes
    #@servidor = Servidor.find_by(hostname: params[:hostname])
    #@op = params[:operacao]
    ## TODO: soft_reboot: reboot from guest shell (guest_ipv4_port, or port 22 for ipv6 conn); hard_reboot: reboot from host (port 22 to host, always)
    ## TODO: reiniciar IF servidor belongs to current_user (var above has to be changed)
    #flash[:success] = 'sucesso'
    #redirect_to servidores_url
  #end

  private

    def set_host
      @host = current_user.hosts.find_by(show_params)
    end

    def show_params
      params.permit(:hostname)
    end

end
