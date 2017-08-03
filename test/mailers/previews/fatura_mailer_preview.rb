# Preview all emails at http://localhost:3000/rails/mailers/fatura_mailer
class FaturaMailerPreview < ActionMailer::Preview
  def nova_fatura
    fatura = Cliente.first.faturas.last
    FaturaMailer.nova_fatura(fatura)
  end

end
