# Preview all emails at http://localhost:3000/rails/mailers/cliente_mailer
class ClienteMailerPreview < ActionMailer::Preview
  def recuperar_senha
    cliente = Cliente.first
    cliente.reset_token = Cliente.new_token
    ClienteMailer.recuperar_senha(cliente)
  end
end
