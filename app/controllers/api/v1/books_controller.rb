class Api::V1::BooksController < Api::V1::SecureController
  before_action :authenticate_user, only: [ :index, :create, :update, :destroy ]

  def index
    books = Book.all
    authorize books

    render jsonapi: books
  end

  def show
    authorize book
    render jsonapi: book
  end

  def create
    authorize book

    if book.save
      render jsonapi: book, status: :created
    else
      unprocessable_entity!(book)
    end
  end

  def update
    authorize book
    if book.update(book_params)
      render jsonapi: book, status: :ok
    else
      unprocessable_entity!(book)
    end
  end

  def destroy
    authorize book
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
