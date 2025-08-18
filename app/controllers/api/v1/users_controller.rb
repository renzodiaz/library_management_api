class Api::V1::UsersController < Api::V1::SecureController
  before_action :authenticate_user, only: [ :index, :show, :update, :destroy ]

  def index
    users = User.all
    render jsonapi: users
  end

  def show
    render jsonapi: user
  end

  def create
    if user.save
      render jsonapi: user, status: :created, location: api_v1_user_url(user)
    else
      unprocessable_entity!(user)
    end
  end

  def update
    if user.update(user_params)
      render jsonapi: user, status: :ok
    else
      unprocessable_entity!(user)
    end
  end

  def destroy
    user.destroy
    render status: :no_content
  end

  private

  def user
    @user ||= params[:id] ? User.find_by!(id: params[:id]) : User.new(user_params)
  end
  alias_method :resource, :user

  def user_params
    params.require(:data).permit(:email, :password, :first_name, :last_name,
                                 :role, :confirmation_redirect_url)
  end
end
