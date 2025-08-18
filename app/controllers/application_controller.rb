class ApplicationController < ActionController::API
  include Authentication

rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

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

  def resource_not_found
    render(status: 404)
  end
end
