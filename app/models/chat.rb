class Chat < ApplicationRecord
  has_many :chat_participants
  has_many :users, through: :chat_participants
  has_many :messages
  has_one :last_message, class_name: 'Message'

  def users_except(user)
    users.where.not(id: user&.id)
  end

  def chat_participant_by_user(user)
    chat_participants.where(user_id: user.id).last
  end

  def unread_messages_count_of_user(user)
    chat_participant_by_user(user)&.unread_messages_count || 0
  end
end
