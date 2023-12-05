require 'rails_helper'

RSpec.describe '/sessions', type: :request do
  describe 'GET /sessions/new' do
    it 'return 200' do
      get '/sessions/new'
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /sessions' do
    subject(:request) { post '/sessions', params: params }

    let(:user) { create(:user) }

    context 'when invalid credentials' do
      let(:params) { { email: user.email, password: 'foo' } }

      it 'show failed flash and not set current_user' do
        request
        expect(flash[:danger]).to eq('Invalid email or password')   
        expect(controller.current_user).to be_nil
      end
    end

    context 'when valid credentials' do
      let(:params) { { email: user.email, password: '12345678' } }
      it 'show success flash and set current user' do
        request
        expect(flash[:success]).to eq('Login successfully')
        expect(controller.current_user).to eq(user)
      end
    end
  end
end
