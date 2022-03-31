require 'rails_helper'

RSpec.describe ChatsController, type: :controller do
  describe 'GET index' do
    let!(:current_user) { FactoryBot.create :user, username: 'Protagonist' }
    let!(:chat) { FactoryBot.create :chat }
    let!(:chat_participant) { FactoryBot.create :chat_participant, user_id: current_user.id, chat_id: chat.id }

    context 'when get a request' do
      before do
        get :index, params: {}, xhr: true
      end

      it 'then a response status is ok' do
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
        it 'then chat id is valid' do
          expect(parsed_body.dig(0, 'id')).to eq(chat.id)
        end
        it 'then first user id is null' do
          expect(parsed_body.dig(0, 'users', 0, 'id')).to be_nil
        end
      end
    end
  end
end
