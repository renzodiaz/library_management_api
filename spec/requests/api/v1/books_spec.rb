require 'rails_helper'

# Api requests
RSpec.describe 'Books', type: :request do
  let(:book_1) { create(:book) }
  let(:book_2) { create(:book_2) }
  let(:book_3) { create(:book_3) }

  let(:books) { [ book_1, book_2, book_3 ] }

  describe 'GET /api/v1/books' do
    # create books before tests
    before { books }

    context 'default request' do
      before { get '/api/v1/books' }

      it 'returns HTTP status 200' do
        expect(response.status).to eq 200
      end

      it 'returns a json with the "data" as root key' do
        expect(json_body['data']).to_not be nil
      end

      it 'returns all 3 books' do
        expect(json_body['data'].size).to eq 3
      end
    end
  end

  describe 'GET /api/v1/books/:id' do
    context 'with existing resource' do
      before { get "/api/v1/books/#{book_1.id}" }

      it 'returns HTTP status 200' do
        expect(response.status).to eq 200
      end

      it 'returns "book_1" book as json' do
        expect(json_body["data"]["title"]).to eq "My first book"
      end
    end

    context 'with not existent resource' do
      it 'returns HTTP status 404' do
        get '/api/v1/books/123123123'
        expect(response.status).to eq 404
      end
    end
  end

  describe 'POST /api/v1/books' do
    let(:author) { create(:john_doe) }
    before { post '/api/v1/books', params: { data: params } }

    context 'with valida parameters' do
      let(:params) do
        attributes_for(:book, author_id: author.id)
      end

      it 'returns HTTP status 201' do
        expect(response.status).to eq 201
      end

      it 'returns the newly created resource' do
        expect(json_body['data']['title']).to eq 'My first book'
      end

      it 'Increases a record in the database' do
        expect(Book.count).to eq 1
      end
    end

    context 'with invalid parameters' do
      let(:params) { attributes_for(:book, title: '') }

      it 'returns HTTP status 422' do
        expect(response.status).to eq 422
      end

      it 'returns the error details' do
        expect(json_body['error']['invalid_params']).to eq(
          { 'author'=>[ 'must exist' ], 'title'=>[ "can't be blank" ] }
        )
      end

      it 'does not not increase record in the database' do
        expect(Book.count).to eq 0
      end
    end
  end

  describe 'PATCH /api/v1/books/:id' do
    before { patch "/api/v1/books/#{book_1.id}", params: { data: params } }

    context 'with valid parameters' do
      let(:params) { { title: 'My updated book' } }

      it 'returns HTTP status 200' do
        expect(response.status).to eq 200
      end

      it 'returns the updated resource' do
        expect(json_body['data']['title']).to eq 'My updated book'
      end

      it 'updates the record in the database' do
        expect(Book.first.title).to eq 'My updated book'
      end
    end

    context 'with invalid parameters' do
      let(:params) { { title: '' } }

      it 'returns HTTP status 422' do
        expect(response.status).to eq 422
      end

      it 'returns the error details' do
        expect(json_body['error']['invalid_params']).to eq(
          { 'title'=>[ "can't be blank" ] }
        )
      end

      it 'does not update the record in the database' do
        expect(Book.first.title).to eq 'My first book'
      end
    end
  end

  describe 'DELETE /api/v1/books/:id' do
    context 'with existing resource' do
      before { delete "/api/v1/books/#{book_1.id}" }

      it 'gets HTTP status 204' do
        expect(response.status).to eq 204
      end

      it 'deletes the book from the database' do
        expect(Book.count).to eq 0
      end
    end

    context 'with nonexistent resource' do
      it 'returns HTTP status 404' do
        delete '/api/v1/books/13123123'
        expect(response.status).to eq 404
      end
    end
  end
end
