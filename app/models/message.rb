class Message < ApplicationRecord
    belongs_to :chat
    belongs_to :user
    has_many :message_viewers
end
