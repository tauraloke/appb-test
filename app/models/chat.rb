class Chat < ApplicationRecord
    has_many :chat_participants
    has_many :users, through: :chat_participants
    has_many :messages
    has_one :last_message, class_name: 'Message'

    def unread_messages_count(user_id)
        chat_participants.where(user_id: user_id).last&.
    end

    def users_except_me(user_id)
        users.where.not(user_id: user_id)
    end
end
