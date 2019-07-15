class UserMailer < ApplicationMailer
	default from: 'lyliyun3@aliyun.com'
 
  def welcome_email(user)
    @user = user
    @url = 'http://192.168.12.138:3000'
    # mail(to: @user.email, subject: 'regist success!')
    mail(to: @user.email, subject: 'regist success!')
  end
end