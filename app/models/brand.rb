class Brand < ApplicationRecord
  has_many :products, dependent: :nullify
end
