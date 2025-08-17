class Api::V1::BooksController < Api::V1::SecureController
  def index
    books = Book.all
    render serialize(books)
  end

  def show
    render serialize(book)
  end

  def create
    if book.save
      render serialize(book).merge(status: :created)
    else
      unprocessable_entity!(book)
    end
  end

  def update
    if book.update(book_params)
      render serialize(book).merge(status: :ok)
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
