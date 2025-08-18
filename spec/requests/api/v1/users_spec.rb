require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include_context 'Skip Auth'

  let(:john) { create(:user) }
  let(:users) { [ john ] }

  describe 'GET /api/v1/users' do
    before do
      get '/api/v1/users'
    end

    it 'returns HTTP status 200' do
      expect(response.status).to eq 200
    end

    it 'returns 1 user' do
      expect(json_body['data'].size).to eq 1
    end
  end

  describe 'GET /api/v1/users/:id' do
    context 'with existing resource' do
      before { get "/api/v1/users/#{john.id}" }

      it 'returns HTTP status 200' do
        expect(response.status).to eq 200
      end
   end

    context 'with inexistent resource' do
      it 'returns HTTP status 404' do
        get '/api/v1/users/2314323'
        expect(response.status).to eq 404
      end
    end
  end

  describe 'POST /api/v1/users' do
    before { post "/api/v1/users", params: { data: params } }

    context 'with valid parameters' do
      let(:params) { attributes_for(:user) }

      it 'returns HTTP status 201' do
        expect(response.status).to eq 201
      end

      it 'returns the newly created resource' do
        expect(json_body['data']['attributes']['email']).to eq 'john@example.com'
      end

      it 'adds a record in the database' do
        expect(User.last.id.to_s).to eq json_body['data']['id']
      end

      it 'returns the new resource location in the Location header' do
        expect(response.headers['Location']).to eq(
          "http://www.example.com/api/v1/users/#{User.last.id}"
        )
      end
    end

    context 'with invalid parameters' do
      let(:params) { attributes_for(:user, email: '') }

      it 'returns HTTP status 422' do
        expect(response.status).to eq 422
      end

      it 'returns an error details' do
        expect(json_body['error']['invalid_params']).to eq(
          { "email" => [ "can't be blank", "is invalid" ] }
        )
      end

      it 'does not create the record in the database' do
        expect(User.where(email: 'john@example.com').first).to eq nil
      end
    end
  end

  describe 'PATCH /api/v1/users/:id' do
    before { patch "/api/v1/users/#{john.id}", params: { data: params } }

    context 'with valid parameters' do
      let(:params) { { email: 'john+1@example.com' } }

      it 'returns HTTP status 200' do
        expect(response.status).to eq 200
      end

      it 'returns the updated resource' do
        expect(json_body['data']['attributes']['email']).to eq 'john+1@example.com'
      end

      it 'updates the record in the database' do
        expect(User.last.email).to eq 'john+1@example.com'
      end
    end

    context 'with invalid parameters' do
      let(:params) { { email: '' } }

      it 'returns HTTP status 422' do
        expect(response.status).to eq 422
      end

      it 'returns an error details' do
        expect(json_body['error']['invalid_params']).to eq({ "email"=>[ "can't be blank", "is invalid" ] })
      end

      it 'does not add a record in the database' do
        expect(User.last.email).to eq 'john@example.com'
      end
    end
  end

  describe 'DELETE /api/v1/users/:id' do
    context 'with existing resource' do
      before { delete "/api/v1/users/#{john.id}" }

      it 'returns HTTP status 204' do
        expect(response.status).to eq 204
      end

      it "deletes the user from the database" do
        expect(User.where(id: john.id).first).to be nil
      end
    end

    context 'with inexistent resource' do
      it 'returns HTTP status 404' do
        delete "/api/v1/users/2314323"
        expect(response.status).to eq 404
      end
    end
  end
end
