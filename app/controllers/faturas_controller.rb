class FaturasController < ApplicationController

  def index
    @faturas = current_user.faturas.order('vencimento DESC')
    #@faturas_abertas = current_user.faturas.where(paga_em: nil)
    #@faturas_fechadas = current_user.faturas.where.not(paga_em: nil)
  end

  def show
    @fatura = current_user.faturas.find(params[:id])
  end

  # Actualiza a via de pagamento
  def update_via
    @fatura = current_user.faturas.find(params[:id])
    if params.has_key?(:via_de_pagamento)
      @fatura.via_de_pagamento = params[:via_de_pagamento]
      @fatura.save!
    end
    respond_to do |format|
      format.js 
    end
  end

  def stripe
    @fatura = current_user.faturas.find(params[:id])

    email = @fatura.cliente.email
    card_token = params[:card_token]

    if @fatura.pagar_stripe(email, card_token)
      @fatura.paga_em = Date.today
      @fatura.paga!
      @fatura.save!
      redirect_to @fatura
    else
      render :show
    end
  end

  private
  
  def stripe_params
    params.permit(:card_token)
  end
end
