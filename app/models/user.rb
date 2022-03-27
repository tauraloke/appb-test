class User < ApplicationRecord
  has_one_attached :avatar
  has_many :chat_participants
  has_many :chats, through: :chat_participants
end
