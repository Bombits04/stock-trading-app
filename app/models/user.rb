class User < ApplicationRecord
  has_many :stock_purchases
  has_many :stocks, through: :stock_purchases
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :encrypted_password, presence: true, length: { minimum: 6 }

  before_validation :set_user_type, :set_to_pending
  after_update :set_to_approved, if: :approved_by_admin?

  private

  def set_user_type
    self.user_type = 'trader' if user_type.blank?
  end

  def set_to_pending
    self.is_pending = true unless is_pending.blank?
  end

  def set_to_approved
    update_column(:is_pending, false)
  end

  def approved_by_admin?
    !is_pending && is_pending_changed?
  end
end
