class Message < ApplicationRecord
    belongs_to :chat
    belongs_to :user
    has_one :message_viewer
end
