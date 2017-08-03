class TicketMailer < ApplicationMailer
  helper :tickets
  
  default from: "EliteBox Geral <geral@elitebox.com.br>",
          sender: 'geral@elitebox.com.br', 
          'Message-ID': "<#{SecureRandom.uuid}@elitebox.com.br>"

  def novo_ticket(ticket)
    @id = ticket.id
    @autor = ticket.cliente.nome    
    @assunto = ticket.assunto
    @resposta = ticket.ticket_respostas.first
    @conteudo = @resposta.mensagem

    add_anexos

    mail to: "#{Admin.first.nome} <#{Admin.first.email}>",
         subject: "[Ticket: ##{@id}] #{@assunto}"
  end

  def nova_resposta(ticket, resposta)
    @id = ticket.id
    @cliente = ticket.cliente
    @resposta = resposta
    @respondente = resposta.respondente.nome
    @assunto = ticket.assunto

    @respondente_tipo = resposta.respondente_type
    @conteudo = resposta.mensagem

    if @respondente_tipo == "Admin"
      # Se o respondente for admin, enviar resposta ao cliente:
      @respondente.prepend("[Admin] ")
      destinatario = "#{@cliente.nome} <#{@cliente.email}>"
    else
      # Se for cliente, enviar resposta ao admin:
      destinatario = "#{Admin.first.nome} <#{Admin.first.email}>"
    end

    add_anexos

    mail to: destinatario,
         subject: "[Ticket: ##{@id}] #{@assunto} | Nova resposta"

  end

  
  private

  def add_anexos
    if @resposta.anexos.present?
      @resposta.anexos.each do |a|
        anexo = a.file
        attachments[anexo.filename] = anexo.read
      end
    end
  end
end
