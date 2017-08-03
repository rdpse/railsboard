module Gestao
  extend ActiveSupport::Concern

  def conectavel?
    system "ssh root@#{self.ip_principal} 'who mom likes'"
  end

  def run(cmd)
    %x{ssh root@#{self.ip_principal} '#{cmd}'}
  end

  def lives(estado)
    update_attribute :alive, status
  end

  def a_reiniciar(estado)
    update_attribute :reiniciando, estado
  end

  def soft_reboot
    self.run('reboot')
  end

  # TODO: move to host model
  def hard_reboot
    case self.isp.nome
    when 'OneProvider'
      op = op_api
      op.post('/server/action/', { 'server_id' => self.isp_server_id.to_i, 'action' => 'reboot' })
    when 'Kimsufi'
      ks = ks_api
      ks.post("/dedicated/server/#{self.isp_hostname}/reboot")
    when 'Scaleway'
      sw_api
      Scaleway::Server.reboot self.isp_server_id
    end
  end

  def ks_api
    k = "#{Rails.application.secrets.kimsufi_consumer_key}"
    i = self.isp
    OVH::REST.new(i.api_pk, i.api_sk,
                  k, i.api_url)
  end

  def op_api
    i = self.isp
    OneProvider::API.new(i.api_pk, i.api_sk)
  end
 
  def sw_api
    i = self.isp
    z = self.scaleway_zone
    Scaleway.token = i
    Scaleway.zone = z
  end

  def limpar_cache_cloudflare
    self.dominios.find_each do |d|
      c = self.cliente
      cloudflare_connect(c.cloudflare_api_key, c.cloudflare_email)
      Cloudflair.zone(d.cloudflare_zone_id).purge_cache.everything(true)
    end
  end
   
  def cloudflare_connect(api_key, email)
    Cloudflair.configure do |config|
      config.cloudflare.auth.key = api_key
      config.cloudflare.auth.email = email
      config.faraday.adapter = :net_http
      config.faraday.logger = :logger
    end
  end

  # Servidor contém domínios na cloudflare?
  def cloudflare?
    self.dominios.find_by(cloudflare: true).present?
  end

end
