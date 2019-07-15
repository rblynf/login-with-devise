class SendMailJob < ApplicationJob
  queue_as :mailers

  def perform(args)
    # Do something later
    user = User.find_by_id(args[:id])
		UserMailer.welcome_email(user).deliver_later 
 	end
end
