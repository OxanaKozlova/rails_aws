class User < ActiveRecord::Base
  acts_as_voter
  ROLES = [ADMIN_ROLE = :admin, MODERATOR_ROLE = :moderator, USER_ROLE = :user].freeze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :age, numericality: {greater_than: 0}
  validates :email, email_format: { :message => 'is not looking good' }
  validates :name, :last_name,  length: { in: 0..255, allow_blank: false }
  before_save :set_role_default

  def role?(user_role)
    role == user_role.to_s
  end

  private
  def set_role_default
    self.role ||= User::USER_ROLE.to_s
  end
end
