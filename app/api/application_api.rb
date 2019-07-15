require "grape-swagger"
class ApplicationAPI < Grape::API
	content_type :json, 'application/json;charset=UTF-8'
	format :json
	mount V1::BaseApi

end