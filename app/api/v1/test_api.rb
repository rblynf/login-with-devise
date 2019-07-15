module V1
  class TestApi < BaseApi
  	namespace :api_test_ly do
      params do
        optional :email, type: String, desc: '邮件'
      end
      get '/' do
				user_list = []
				info = User.ransack(email_cont: params[:email]).result.select("id,email")
				info.each do |list|
					user_list << list.as_json
				end
				user_list
      end
    end
	end
end