class ProductStack < ApplicationRecord
  belongs_to :stack
  belongs_to :product
end
