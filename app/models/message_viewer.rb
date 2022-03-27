class MessageViewer < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  belongs_to :message
end
