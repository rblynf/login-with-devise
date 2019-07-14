#处理respond
module Helpers
  module RespondHelper

    #返回成功的状态
    def generate_success_response(response_body, code = 40000)
      message = build_response_message_body({}, response_body, code)
      if request.headers["Format"] == "application/xml"
        message.to_xml
      elsif request.headers['Format'] == "application/json"
        message
      elsif request.headers['Format'] == "text/plain"
        message.to_s
      else
        message
      end
    end

    #返回错误的状态
    def generate_error_response!(error)
      error_class_name = error.class.name
      code = ErrorCode.get_code(error_class_name)
      code = -1 if code.blank?
      status = ErrorCode.get_status(error_class_name)
      status = 500 if status.blank?
      error_data = {
          :code => code ,
          :error_class => error.class.name,
          :message => error.message
      }
      message = build_response_message_body(error_data, {}, code)
      status = 400 if status.blank?
      error_response!(message.to_json,status)
    end

    private

    def request
      @request ||= Grape::Request.new(self.env)
    end

    def error_response!(message,status = 400,headers ={},backtrace = [], original_exception = nil)
      headers = headers.reverse_merge(Grape::Http::Headers::CONTENT_TYPE => content_type)
      rack_response(message,status,headers)
    end


    def request_info
      # headers = request.env.select{|k,v| k.start_with? 'HTTP_'}
      #         .collect{|pair|[pair[0].sub('/^HTTP_/',''),pair[1]]}
      #         .collect{|pair| pair.join(":") << "<br>"}
      #         .sort
      {
          :href => request.url,
          :query_params => request.query_string,
          :body => request.body.read
      }
    end

    def build_response_message_body(error_data, response_body, code)
      if error_data.present?
        {
            :error_code => code,
            :error_message => error_data,
            :x_server_current_time => Time.now,
            # :request => request_info,
            :response => response_body
        }
      else
        {
            :response => response_body,
            :x_server_current_time => Time.now,
            # :request => request_info,
        }
      end
    end
  end
end
