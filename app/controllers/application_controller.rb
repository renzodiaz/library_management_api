class ApplicationController < ActionController::API
  protected

  def unprocessable_entity!(resource)
    render status: :unprocessable_content, json: {
      error: {
        message: "Invalid parameters for resource #{resource.class}",
        invalid_params: resource.errors
      }
    }
  end

  def serialize(resource, options = {})
    {
      json: {
        data: resource,
        params: params,
        options: options
      }.to_json
    }
  end
end
