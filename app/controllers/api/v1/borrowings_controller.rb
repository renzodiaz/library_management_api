class Api::V1::BorrowingsController < Api::V1::SecureController
  before_action :authenticate_user, only: [ :index, :show, :create, :return_book ]

  def index
    borrowings = policy_scope(Borrowing)

    render jsonapi: borrowings
  end

  def show
    authorize borrowing

    render jsonapi: borrowing
  end

  def create
    borrowing.user = current_user

    authorize borrowing

    unless borrowing.book.is_available?(current_user.id)
      return render json: { errors: "Book is not available at the momment" }, status: :unprocessable_entity
    end

    borrowing.borrowed_at = Time.current
    borrowing.due_date = 2.weeks.from_now

    if borrowing.save
      render jsonapi: borrowing, status: :created
    else
      unprocessable_entity!(borrowing)
    end
  end

  def return_book
    borrowing = Borrowing.find(params[:id])
    authorize borrowing, :return_book?

    borrowing.update_columns(
      due_date: nil,
      returned_at: Time.current
    )

    render jsonapi: borrowing
  end

  private

  def borrowing
    @borrowing ||= params[:id] ? Borrowing.find_by!(id: params[:id]) : Borrowing.new(borrowing_params)
  end
  alias_method :resource, :borrowing

  def borrowing_params
    params.require(:data).permit(:book_id)
  end
end
