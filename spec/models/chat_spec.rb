RSpec.describe 'Chat' do
  context '#users_except' do
    it 'when no users then no users' do
      let! :chat, {}
      expect(chat.users_except(user).count).to eq(0)
    end
  end
end