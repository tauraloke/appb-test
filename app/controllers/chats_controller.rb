class ChatsController < ApplicationController
    def index
        @chats = current_user.chats.limit(limit).offset(offset).order(updated_at: :desc)
    end
end
