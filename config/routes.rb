Rails.application.routes.draw do

  get 'painel/index',                        to: 'painel#index',         as: 'index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root 'servidores#index'

  get '/',                                   to:  'servidores#index',    as: 'servidores'
  get '/servidores/:hostname',               to:  'servidores#show',     as: 'servidor',
                                             constraints: { hostname: /[\w+\.]+/ }

  post '/servidores/limpar_cache',           to: 'servidores#limpar_cache'
  post '/servidores/reiniciar',              to: 'servidores#reiniciar'

  get '/servidores/reload_servidor',          to: 'servidores#reload_servidor'

  get '/intervencoes',                       to: 'intervencoes#index',   as: 'intervencoes'
  get '/intervencoes/:id',                   to: 'intervencoes#show',    as: 'intervencao'

  get '/faturas',                            to: 'faturas#index',        as: 'faturas'
  get '/faturas/:id',                        to: 'faturas#show',         as: 'fatura'
  post '/faturas/:id/stripe',                to: 'faturas#stripe',       as: 'stripe'
  post '/faturas/:id/update_via',            to: 'faturas#update_via'

  get '/tickets',                            to: 'tickets#index',        as: 'tickets'
  get '/tickets/novo',                       to: 'tickets#new' 
  post '/tickets/novo',                      to: 'tickets#create'
  get '/tickets/:id',                        to: 'tickets#show',         as: 'ticket'
  post '/tickets/:id',                       to: 'tickets#update', 	 		 as: 'ticket_update'
  post '/tickets/:id/fechar',                to: 'tickets#fechar',       as: 'ticket_fechar'
  post '/tickets/:id/reabrir',               to: 'tickets#reabrir',      as: 'ticket_reabrir'

  get '/perfil',                             to: 'clientes#edit',        as: 'perfil_editar'
  patch '/perfil',                           to: 'clientes#update',      as: 'perfil_update'

  # Login related #
  get '/login',                              to: 'sessions#new' 
  post '/login',                             to: 'sessions#create'
  delete '/logout',                          to: 'sessions#destroy'

  # Recuperação de senhas #
  resources :tickets
  resources :recuperar_senhas,               path: '/recuperar',         only: [:new, :create, :edit, :update]
end

