require 'net/ping'

namespace :server_status do
  desc 'O servidor está ON ou OFF?'
  task alive: :environment do
    Host.find_each do |h|
      unless h.cancelado?
        ip = h.ip_principal
        server_on = Net::Ping::External.new(ip)
        ping = server_on.ping?
        if ping
          puts "Server is up."
          h.lives(true) 
        else
          puts "Server is down."
          h.lives(false)
        end
      end
    end
  end
end
