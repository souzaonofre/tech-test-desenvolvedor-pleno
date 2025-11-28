class Email < ApplicationRecord
  belongs_to :customer, counter_cache: true
  validates :produto, :assunto, :contexto, presence: true

end
