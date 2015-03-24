module Api
  class BaseController < ActionController::Metal
    include AbstractController::Rendering

    include ActionController::UrlFor
    include ActionController::Head
    include ActionController::Rendering
    include ActionController::Renderers::All
    include ActionController::ConditionalGet
    include ActionController::MimeResponds
    include ActionController::ImplicitRender
    include ActionController::RespondWith
    include ActionController::StrongParameters
    include ActionController::Serialization

    include Rails.application.routes.url_helpers

    # Before callbacks should also be executed the earliest as possible, so
    # also include them at the bottom.
    include AbstractController::Callbacks
    include Doorkeeper::Rails::Helpers

    include CanCan::ControllerAdditions

    # The same with rescue, append it at the end to wrap as much as possible.
    include ActionController::Rescue

    respond_to :json

    # You might need to comment out the next line for debugging
    rescue_from Exception, with: :error_during_processing
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from CanCan::AccessDenied, with: :unauthorized
    rescue_from ActionController::ParameterMissing, with: :parameter_missing

    before_action :doorkeeper_authorize!

    def current_user
      if doorkeeper_token
        @current_user ||= User.find(doorkeeper_token.resource_owner_id)
      end
    end

    def invalid_record!(record)
      render json: {
        message: I18n.t('errors.invalid_record'), errors: record.errors
      }, status: :unprocessable_entity
    end

    private

    def error_during_processing(exception)
      Rails.logger.error exception.message
      Rails.logger.error exception.backtrace.join("\n")
      render text: { exception: exception.message }.to_json, status: 500 and return
    end

    def not_found
      render json: {
        message: I18n.t('errors.not_found')
      }, status: :not_found
    end

    def unauthorized
      render json: {
        message: I18n.t('errors.forbidden_operation')
      }, status: :forbidden
    end

    def parameter_missing(exception)
      render json: {
        message: I18n.t('errors.parameter_missing', param: exception.param)
      }, status: :bad_request
    end
  end
end
