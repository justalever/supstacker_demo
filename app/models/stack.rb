class Stack < ApplicationRecord
  belongs_to :user
  has_many :product_stacks
  has_many :products, through: :product_stacks
end
