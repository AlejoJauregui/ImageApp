module Api
    module V1
        class ApiApplicationController < ActionController::Base

            #Current User method
            attr_reader :current_user
            skip_before_action :verify_authenticity_token #For Chrome and Rails 5.2.x this permit use API from  the localhost
            protected
            def authenticate_request!
                unless user_id_in_token?
                    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
                    return
                end
                @current_user = User.find(auth_token[:user_id])
                rescue JWT::VerificationError, JWT::DecodeError
                render json: { errors: ['Not Authenticated'] }, status: :unauthorized
            end
            
            #http token method
            private
            def http_token
                @http_token ||= if request.headers['Authorization'].present?
                	  request.headers['Authorization'].split(' ').last
                end
            end
            #Authentication Token method
            def auth_token
                @auth_token ||= JsonWebToken.decode(http_token)
            end
            def user_id_in_token?
                http_token && auth_token && auth_token[:user_id].to_i
            end

        end
    end
end
