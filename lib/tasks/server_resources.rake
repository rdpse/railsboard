require 'ruport'

namespace :server_resources do
  desc 'Espaço total, espaço utilizado'
  task hdd: :environment do 
    Host.find_each { |h| h.actualizar_hdd unless h.windows || h.cancelado? }
  end

  desc 'Ram total, ram utilizada'
  task ram: :environment do
    Host.find_each { |h| h.actualizar_ram unless h.windows || h.cancelado? }
  end

  desc 'Tráfego consumido'
  task trafego: :environment do
    Host.find_each { |h| h.actualizar_trafego unless h.windows || h.cancelado? }
  end
end
