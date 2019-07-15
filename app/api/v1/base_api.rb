module V1
  class BaseApi < Grape::API
    mount V1::TestApi

    add_swagger_documentation(
	    base_path: "/api",
	    hide_documentation_path: true,
	    hide_format: true,
	  )
	end
end
