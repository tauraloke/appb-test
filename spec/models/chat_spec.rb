require 'rails_helper'

RSpec.describe Chat, type: :model do
  let!(:chat) { FactoryBot.create(:chat) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:another_user) { FactoryBot.create(:user) }

  context '#users_except' do
    it 'when no users then no users' do
      expect(chat.users_except(user).count).to eq(0)
    end

    context 'when only `user` a user' do
      let!(:chat_participant) { FactoryBot.create(:chat_participant, user_id: user.id, chat_id: chat.id) }
      it 'then zero excepted users' do
        expect(chat.users_except(user).count).to eq(0)
      end
    end

    context 'when many users' do
      let!(:chat_participant2) { FactoryBot.create(:chat_participant, user_id: another_user.id, chat_id: chat.id) }
      it 'then excepted users exists' do
        expect(chat.users_except(user).count).to eq(1)
      end
    end
  end

  context '#unread_messages_count_of_user' do
    context 'when has no chat_participants' do
      it 'then a count is zero' do
        expect(chat.unread_messages_count_of_user(user)).to eq(0)
      end
    end

    context 'when has participant with unread messages' do
      let!(:unread_messages_count) { 1 }
      let!(:chat_participants) do
        FactoryBot.create(:chat_participant, user_id: user.id, chat_id: chat.id, unread_messages_count: unread_messages_count)
      end
      it 'then a count is not zero' do
        expect(chat.unread_messages_count_of_user(user)).to eq(unread_messages_count)
      end
    end
  end
end
