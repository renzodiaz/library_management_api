require 'rails_helper'

# Api requests
RSpec.describe 'Borrowings', type: :request do
  include_context 'Skip Auth'

  let(:member) { current_user }
  let(:librarian) { create(:user, role: :librarian) }
  let(:book) { create(:book) }

  describe 'GET /api/v1/borrowings' do
    let!(:borrowing) { create(:borrowing, user: member, book: book)  }

    context 'as a member' do
      it 'returns only own borrowings' do
        get '/api/v1/borrowings'

        expect(response.status).to eq 200
        expect(json_body['data'].size).to eq 1
        expect(json_body['data'][0]['attributes']['user_id']).to eq member.id
      end
    end

    context 'as a librarian' do
      it 'returns all borrowings' do
        get '/api/v1/borrowings'
        expect(response.status).to eq 200
        expect(json_body['data'].size).to eq 1
      end
    end
  end

  describe 'POST /api/v1/borrowings' do
    include_context 'Skip Auth', :user # current_user type member
    before { post '/api/v1/borrowings', params: { data: params } }

    context 'when book is available' do
      let(:params) do
        attributes_for(:borrowing, book_id: book.id)
      end

      it 'creates a new borrowing' do
        expect(response.status).to eq 201
        expect(Borrowing.count).to eq 1
        expect(Borrowing.last.book).to eq book
        expect(Borrowing.last.user).to eq member
      end
    end

    context 'when book is already borrowed' do
      let(:params) do
        attributes_for(:borrowing, book_id: book.id, returned_at: nil)
      end

      it 'returns 422 and does not create a record' do
        post '/api/v1/borrowings', params: { data: params  }
        expect(response.status).to eq 422
        expect(Borrowing.count).to eq 1
      end
    end
  end

  # TODO: make return test
end
