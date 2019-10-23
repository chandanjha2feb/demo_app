class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :secret_code
  accepts_nested_attributes_for :secret_code

  validates_presence_of :email, :first_name, :last_name
  # validate :secret_code, :presence => true, if: Proc.new { |c| c.user.has_secret_code?}
  def is?( requested_role )
    self.role == requested_role.to_s
  end

end
