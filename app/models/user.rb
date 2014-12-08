class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #/config/initializers/devise.erb enabled autentication key as :login
  attr_accessor :login #alias for login with email or username
  
  validates :username, :nombre, :presence => { message: "No puede dejarse vacío" }  
  #roles for user
  enum role: [:ninguno, :admin, :vigilante]

  
  validates :username, presence: true, length: {in: 4..20}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "Solo puede contener letras y números" }

protected
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
