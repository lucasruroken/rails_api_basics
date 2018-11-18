module RailsApiBasics
  class BaseController < ::ActionController::API
    include ::RailsApiBasics::ApiAuthenticable

    before_action :validate_client_app!
    before_action :authenticate_user!
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def ping
      render json: { success: true }
    end

    private

    def validate_client_app!
      @api_key = ApiKey.find_by(token: request.headers['app-id'])
      unauthenticated! if @api_key.nil?
    end

    def unauthenticated!
      response.headers['WWW-Authenticate'] = "Token realm=Application"
      render json: { error: 'Bad credentials' }, status: 401
    end

    def record_not_found
      render json: { error: 'Record not found' }, status: 404
    end
  end
end