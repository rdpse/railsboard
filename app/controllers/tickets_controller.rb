class TicketsController < ApplicationController
  before_action :set_ticket, except: [:index, :new, :create]
  respond_to? :html, :js

  def index
    @tickets = current_user.tickets.order('created_at DESC')
  end

  def show
    @ticket = current_user.tickets.find(params[:id])
    @respostas = @ticket.ticket_respostas.all
    @resposta = @ticket.ticket_respostas.new
  end

  def new
    @ticket = current_user.tickets.new
    @resposta = @ticket.ticket_respostas.new
  end

  def create
    @ticket = current_user.tickets.new(ticket_params)

    # We don't want our reply to be an orphan 
    @ticket.ticket_respostas.first.respondente_id = current_user.id
    @ticket.ticket_respostas.first.respondente_type = current_user.class.name

    if @ticket.save
      @ticket.aberto!
      @ticket.notificar_admin
      redirect_to ticket_path(@ticket)
    else
      flash.now[:danger] = "Não foi possível criar o ticket."
      render 'new'
    end
  end

  def update
    @resposta = current_user.ticket_respostas.new(resposta_params)

    if @resposta.save!
      @resposta.respondido! if @resposta.respondente_type == "Admin"

      # Enviar email ao cliente
      @resposta.notificar

      @respostas = @ticket.ticket_respostas.all  # needed because of @respostas.first = resposta in partial
    else
      redirect_to ticket_path(@ticket)
    end
  end
  
  def fechar
    @ticket.fechado!
    redirect_to tickets_path
  end

  def reabrir
    @ticket.aberto!
    redirect_to tickets_path
  end


  private

    def resposta_params
      hash = {}
      hash = params.require(:ticket_resposta).permit(:mensagem, {anexos: []})

      # Let's throw the ticket_id in there as well
      data = hash.merge ticket_id: params[:id]
    end
     
    def ticket_params
      params.require(:ticket).permit(:assunto, ticket_respostas_attributes: [:mensagem, {anexos: []}])
    end

    def set_ticket
      @ticket = current_user.tickets.find(params[:id])
    end
end
