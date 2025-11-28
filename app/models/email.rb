class Email < ApplicationRecord
  belongs_to :customer, counter_cache: true

end
