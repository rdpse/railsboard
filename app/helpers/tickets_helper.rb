module TicketsHelper
  def formatar(mensagem)
    simple_format(mensagem).gsub(
      URI.regexp(['http','https','ftp']), 
      '<a href="\0" target="_blank">\0</a>'
    ).html_safe
  end

  def ticket_status(ticket)
    ticket.status.capitalize.gsub("_", " ")
  end

  def ticket_status_color(ticket)
    case ticket.status
    when "aberto"
      "blue"
    when "fechado"
      ""
    when "em_progresso"
      "green"
    when "respondido"
      "red"
    end
  end

  def ticket_label(ticket)
    case ticket.status
    when "aberto"
      "info"
    when "fechado"
      "default"
    when "em_progresso"
      "success"
    when "respondido"
      "danger"
    end
  end

  def anexo_nome(anexo)
    anexo.url.split('/').last
  end

end
