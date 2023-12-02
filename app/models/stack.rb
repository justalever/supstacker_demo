class Stack < ApplicationRecord
  belongs_to :user
  has_many :product_stacks
  has_many :products, through: :product_stacks

  before_create :generate_unique_share_link

  def generate_unique_share_link
    loop do
      self.share_link = generate_random_string
      break unless Stack.exists?(share_link: share_link)
    end
  end

  def generate_random_string
    SecureRandom.urlsafe_base64(6)
  end
end
