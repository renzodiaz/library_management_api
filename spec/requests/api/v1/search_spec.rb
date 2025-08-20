require 'rails_helper'

RSpec.describe 'Search', type: :request do
  before do
    allow_any_instance_of(::Api::V1::SearchController).to(
      receive(:validate_auth_scheme).and_return(true)
    )
    allow_any_instance_of(::Api::V1::SearchController).to(
      receive(:authenticate_client).and_return(true)
    )
  end

  let(:book1) { create(:book) }
  let(:book2) { create(:book_2) }
  let(:book3) { create(:book_3) }
  let(:books) { [ book1, book2, book3 ] }

  describe 'GET /api/v1/search/:text' do
    before do
      books
    end

    context 'with title contains "first"' do
      before { get '/api/v1/search/first' }

      it 'returns HTTP status 200' do
        expect(response.status).to eq 200
      end

      it 'returns a "first" book' do
        expect(json_body['data'][0]['id'].to_i).to eq book1.id
        expect(json_body['data'][0]['attributes']['title']).to eq 'My first book'
      end
    end

    context 'with genre contains "comic"' do
      before { get '/api/v1/search/comic' }

      it 'returns HTTP status 200' do
        expect(response.status).to eq 200
      end

      it 'returns a "comic" book' do
        expect(json_body['data'][0]['id'].to_i).to eq book2.id
        expect(json_body['data'][0]['attributes']['genre']).to eq 'comic'
      end
    end

    context 'with author name contains "John"' do
      before { get '/api/v1/search/john' }

      it 'returns HTTP status 200' do
        expect(response.status).to eq 200
      end

      it 'returns 3 books author "John"' do
        expect(json_body['data'].size).to eq 3
      end
    end
  end
end
