class ApplicationController < ActionController::API
  include Authentication

rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found
rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def builder_error(error)
    render status: 400, json: {
      error: {
        type: error.class,
        message: error.message,
        invalid_params: error.invalid_params
      }
    }
  end

  def unprocessable_entity!(resource)
    render status: :unprocessable_content, json: {
      error: {
        message: "Invalid parameters for resource #{resource.class}",
        invalid_params: resource.errors
      }
    }
  end

  def user_not_authorized
    render status: :forbidden, json: {
      error: {
        message: "This user is not allowed to perform this action."
      }
    }
  end

  def resource_not_found
    render(status: 404)
  end
end
