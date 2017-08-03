namespace :gerar_faturas do
  desc 'Gerar faturas de servidores que estejam a vencer.'
  task criar: :environment do
    Host.find_each do |h|
      if h.a_vencer?
        h.criar_fatura_e_item unless h.faturado? || h.cancelado?
      end
    end
  end
end
