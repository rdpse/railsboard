class ClienteMailer < ApplicationMailer
  default from: "EliteBox Geral <geral@elitebox.com.br>",
          sender: 'geral@elitebox.com.br', 
          'Message-ID': "<#{SecureRandom.uuid}@elitebox.com.br>"

  def bem_vindo(cliente)
    @cliente = cliente

    @assunto = "Bem-vindo à EliteBox"
    mail to: "#{@cliente.nome} <#{@cliente.email}>",
         subject: @assunto
  end

  def recuperar_senha(cliente)
    @cliente = cliente

    @assunto = "Recuperação de Senha"
    mail to: "#{@cliente.nome} <#{@cliente.email}>",
         subject: @assunto
  end
end
