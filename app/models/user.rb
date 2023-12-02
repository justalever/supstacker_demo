class User < ApplicationRecord
  has_person_name
  has_one_attached :avatar

  has_many :stacks
  has_many :products, through: :stacks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
