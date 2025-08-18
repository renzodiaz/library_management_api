class Api::V1::BooksController < Api::V1::SecureController
  before_action :authenticate_user, only: [ :create, :update, :destroy ]

  def index
    books = Book.all
    render jsonapi: books
  end

  def show
    render jsonapi: book
  end

  def create
    if book.save
      render jsonapi: book, status: :created
    else
      unprocessable_entity!(book)
    end
  end

  def update
    if book.update(book_params)
      render jsonapi: book, status: :ok
    else
      unprocessable_entity!(book)
    end
  end

  def destroy
    book.destroy
    render status: :no_content
  end

  private

  def book
    @book ||= params[:id] ? Book.find_by!(id: params[:id]) : Book.new(book_params)
  end

  def book_params
    params.require(:data).permit(:title, :genre, :isbn, :author_id)
  end
end
