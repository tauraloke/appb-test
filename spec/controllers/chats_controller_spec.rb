require 'rails_helper'

RSpec.describe ChatsController, type: :controller do
  describe 'GET index' do
    let!(:current_user) { FactoryBot.create :user, username: 'Protagonist' }
    let!(:chat) { FactoryBot.create :chat }
    let!(:chat_participant) { FactoryBot.create :chat_participant, user_id: current_user.id, chat_id: chat.id }

    before do
      get :index, params: {}, xhr: true
    end

    it 'valid' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('index')
      expect(response.content_type).to eq('application/json; charset=utf-8')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.dig(0, 'id')).to eq(chat.id)
      expect(parsed_body.dig(0, 'users', 0, 'id')).to be_nil
    end
  end
end
