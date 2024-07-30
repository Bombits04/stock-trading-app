class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  validates :encrypted_password, presence: true, length: { minimum: 6 }

  before_validation :set_user_type

  private

  def set_user_type
    self.user_type = "trader" if self.user_type.blank?
  end

end
