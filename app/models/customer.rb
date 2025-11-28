class Customer < ApplicationRecord
  has_many :emails
  validates :nome, :email, :telefone, presence: true
  validates :nome, length: { minimum: 3, message: "nome deve ter pelo menos 3 caracteres" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "email com formato inválido" } 
  validates :telefone, length: { minimum: 10, message: "telefone deve ter codigo de area no total minimo de 10 digitos" }
end
