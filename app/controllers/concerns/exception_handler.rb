module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
    rescue_from CustomError, with: :custom_error
    # rescue_from StandardError, with: :internal_server_error
  end

  private

  def record_not_found(exception)
    render json: {
      error: "Record not found",
      message: exception.message
    }, status: :not_found
  end

  def record_invalid(exception)
    render json: {
      error: "Validation failed",
      message: exception.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  def record_not_unique(exception)
    render json: {
      error: "Duplicate record",
      message: exception.message
    }, status: :unprocessable_entity
  end

  def internal_server_error(exception)
    Rails.logger.error exception.message
    Rails.logger.error exception.backtrace.join("\n")

    render json: {
      error: "Internal server error",
      message: "Something went wrong"
    }, status: :internal_server_error
  end

  def custom_error(exception)
    render json: {
      error: exception.message
    }, status: exception.status
  end
end