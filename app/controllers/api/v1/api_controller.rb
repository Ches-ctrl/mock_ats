class Api::V1::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :skip_session_storage
  before_action :check_json_request
  skip_before_action :turbo_frame_request_variant

  layout false
  respond_to :json

  rescue_from Exception,                           with: :render_error
  rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
  rescue_from ActionController::RoutingError,      with: :render_not_found
  rescue_from AbstractController::ActionNotFound,  with: :render_not_found
  rescue_from ActionController::ParameterMissing,  with: :render_parameter_missing

  def check_json_request
    return unless %w[POST PUT OPTIONS].include? request_method

    return if request_empty_body? || request_content_type&.match?(/json/)

    render json: { error: I18n.t('api.errors.invalid_content_type') }, status: :not_acceptable
  end

  def skip_session_storage
    # Devise stores the cookie by default, so in api requests, it is disabled
    # http://stackoverflow.com/a/12205114/2394842
    request.session_options[:skip] = true
  end

  def request_empty_body?
    request.raw_post.empty?
  end

  def request_content_type
    request.media_type
  end

  def request_method
    request.method
  end

  private

  def render_error(exception)
    raise exception if Rails.env.test?

    # To properly handle RecordNotFound errors in views
    return render_not_found(exception) if exception.cause.is_a?(ActiveRecord::RecordNotFound)

    logger.error(exception) # Report to your error managment tool here

    return if performed?

    render json: { error: ErrorMessage.message_for('INTERNAL_SERVER_ERROR') || I18n.t('api.errors.server') }, status: :internal_server_error
  end

  def render_not_found(exception)
    logger.info(exception) # for logging
    render json: { error: ErrorMessage.message_for('NOT_FOUND') || I18n.t('api.errors.not_found') }, status: :not_found
  end

  def render_record_invalid(exception)
    logger.info(exception) # for logging
    render json: { errors: ErrorMessage.message_for('UNPROCESSABLE') || exception.record.errors.as_json }, status: :bad_request
  end

  def render_parameter_missing(exception)
    logger.info(exception) # for logging
    render json: { error: ErrorMessage.message_for('PARAMETER_MISSING') || I18n.t('api.errors.missing_param') }, status: :unprocessable_entity
  end

  def render_success(message)
    render json: { message: message }, status: :ok
  end
end
