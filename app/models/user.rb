class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :async

  after_create :send_email

  def admin?
    self.role == "admin"
  end

  def client?
		self.role == "client"
  end

  def send_email
    UserMailer.welcome_email(self).deliver_later
  end
end
