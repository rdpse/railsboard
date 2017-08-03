class VigiarServidorJob < ApplicationJob
  queue_as :default

  def perform(host)
    if host.conectavel?
      host.a_reiniciar(false) 
      host.lives(true)
    else
      host.hard_reboot

      host.a_reiniciar(true)
      host.lives(false)
      self.set(wait: 5.minutes).perform_later(host)
    end
  end
end
