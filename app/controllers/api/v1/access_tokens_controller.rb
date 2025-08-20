class Api::V1::AccessTokensController < Api::V1::SecureController
  before_action :authenticate_user, only: :destroy

  def create
    skip_authorization
    user = User.find_by!(email: login_params[:email])

    if user.authenticate(login_params[:password])
      AccessToken.find_by(user: user, api_key: api_key).try(:destroy)

      access_token = AccessToken.create(user: user, api_key: api_key, accessed_at: Time.now)

      render jsonapi: access_token, include: [ :user ], fields: { users: [ :first_name, :last_name, :role ] }, status: :created
    else
      render status: :unprocessable_entity,
        json: { error: { message: "Invalid credentials." } }
    end
  end

  def destroy
    authorize(access_token)

    access_token.destroy
    render status: :no_content
  end

  private

  def login_params
    params.require(:data).permit(:email, :password)
  end
end
