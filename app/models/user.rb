class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :books, dependent: :destroy
  attachment :profile_image
    
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, 
         :validatable
        # , :authentication_keys => [:login]

  # has_many :post_images, dependent: :destroy
  # attr_accessor :login

  validates :name,
  :uniqueness => {
    :case_sensitive => false
  }

  # def self.find_first_by_auth_conditions(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["name = :value OR lower(email) = lower(:value)", { :value => login }]).first
  #   else
  #     where(conditions).first
  #   end
  # end
  
  
  validates :name,
  uniqueness: { case_sensitive: :false },
  length: { minimum: 2, maximum: 20 }
  
  validates :introduction,
  length: { maximum: 50 }
end
