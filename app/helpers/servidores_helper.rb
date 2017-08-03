module ServidoresHelper

  def razao(usado, total)
    razao = usado * 100 / total rescue nil
    razao.to_i
  end

  def pg_bar_color(usage)
    case 
    when usage > 90
      "red"
    when usage > 75
      "orange"
    else
      "green"
    end
  end

  def data_intervencao(intervencao)
    if intervencao.agendada?
      phrase= 'Começa daqui a '
      time = intervencao.agendado_para

    else 
      phrase = 'Actualizado há '
      time = intervencao.updated_at
    end
    phrase + " " + time_ago_in_words(time)
  end

end
