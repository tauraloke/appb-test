require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe 'GET index' do
    let!(:current_user) { FactoryBot.create :user, username: 'Protagonist' }
    let!(:second_user) { FactoryBot.create :user, username: 'Protagonist' }
    let!(:chat) { FactoryBot.create :chat }
    let!(:chat_participant) { FactoryBot.create :chat_participant, user_id: current_user.id, chat_id: chat.id }
    let!(:chat_participant2) { FactoryBot.create :chat_participant, user_id: second_user.id, chat_id: chat.id }
    let!(:message) { FactoryBot.create :message, user_id: current_user.id, chat_id: chat.id, content: '~content~' }

    before do
      get :index, params: { chat_id: chat.id }, xhr: true
    end

    it 'valid' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('index')
      expect(response.content_type).to eq('application/json; charset=utf-8')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.dig(0, 'id')).to eq(message.id)
      expect(parsed_body.dig(0, 'username')).to eq(current_user.username)
      expect(parsed_body.dig(0, 'content')).to eq(message.content)
    end

  end
end