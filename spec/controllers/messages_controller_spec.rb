require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let!(:current_user) { FactoryBot.create :user, username: 'Protagonist' }
  let!(:second_user) { FactoryBot.create :user, username: 'Antagonist' }
  let!(:chat) { FactoryBot.create :chat }
  let!(:chat_participant) { FactoryBot.create :chat_participant, user_id: current_user.id, unread_messages_count: 1, chat_id: chat.id }
  let!(:chat_participant2) { FactoryBot.create :chat_participant, user_id: second_user.id, chat_id: chat.id }
  let!(:message) { FactoryBot.create :message, user_id: second_user.id, chat_id: chat.id, content: '~content~' }

  describe 'GET index' do
    context 'when get a request' do
      before do
        get :index, params: { chat_id: chat.id }, xhr: true
      end

      it 'then HTTP status is OK' do
        expect(response).to have_http_status(:ok)
      end
      it 'then an using template is `index`' do
        expect(response).to render_template('index')
      end
      it 'then a response content type is JSON' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      context 'and when a response body is parsed' do
        let(:parsed_body) { JSON.parse(response.body) }
        it 'then message id is valid' do
          expect(parsed_body.dig(0, 'id')).to eq(message.id)
        end
        it 'then first user in a response has a valid username' do
          expect(parsed_body.dig(0, 'username')).to eq(second_user.username)
        end
        it 'then a message content is valid' do
          expect(parsed_body.dig(0, 'content')).to eq(message.content)
        end
      end
    end
  end

  describe 'PUT mark_as_read' do
    context 'when get a request' do
      before do
        put :mark_as_read, params: { ids: [message.id], chat_id: chat.id }, xhr: true
      end

      it 'then HTTP status is OK' do
        expect(response).to have_http_status(:ok)
      end
      it 'then a response content type is JSON' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      context 'and when a response body is parsed' do
        let(:parsed_body) { JSON.parse(response.body) }
        it 'then message id is valid' do
          expect(parsed_body['status']).to eq('OK')
        end
      end
      it 'then created a new message viewer record' do
        expect(MessageViewer.where(user_id: current_user.id, message_id: message.id).count).to eq(1)
      end
      it 'then updated a message counter for a user in the chat' do
        expect(chat_participant.reload.unread_messages_count).to eq(0)
      end
    end
  end
end
