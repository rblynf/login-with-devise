class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :async

  # after_create :send_email  #若send_email出现异常，因为还未commit因此会出现回滚，user对象未保存成功。
  after_create_commit :send_email #send_email出现异常也不会回滚

  has_many :chat_rooms, dependent: :destroy

  def admin?
    self.role == "admin"
  end

  def client?
		self.role == "client"
  end

  def client_manage?
    self.role == "client_manage"
  end

  def send_email
    UserMailer.welcome_email(self).deliver_later
  end

  def name
    email.split('@')[0]
  end

end
