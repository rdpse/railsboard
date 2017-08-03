module OperacoesHelper
  require 'cloudflair'
  require 'net/ping'
  require 'ovh/rest'
  require 'oneprovider/api'

  # TODO: this should be removed; host already has this capability
  def run(cmd, host_ip)
    user = 'root'
    ip = host_ip
    port = 22

    @cmd = system "ssh -p #{port} #{user}@#{ip} '#{cmd}'" 
    logger.info @cmd
  end
  
  # TODO: move to host model
  def soft_reboot(host_ip)
    run('reboot', host_ip)
  end

  # TODO: move to host model
  def hard_reboot(host)
    case host.isp.nome
    when 'OneProvider'
      op = op_api
      op.post('/server/action/', { 'server_id' => host.isp_server_id, 'action' => 'reboot' })
    when 'Kimsufi'
      ks = ks_api
      ks.post("/dedicated/server/#{host.isp_hostname}/reboot")
    end
  end

  # TODO: move this to host model
  def conectavel?(ip)
    system "ssh root@#{ip} 'who mom likes'"
  end

  def ks_api
    consumer_key = "U5JfuAqmUGmo314dPBbDIGqFRsekEJut"
    isp = @host.isp
    OVH::REST.new(isp.api_pk, isp.api_sk,
                  consumer_key, isp.api_url)
  end

  def op_api
    isp = @host.isp
    OneProvider::API.new(isp.api_pk, isp.api_sk)
  end
end
