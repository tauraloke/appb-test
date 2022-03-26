class ChatsController < ApplicationController
    def index
        @chats = current_user.chats.includes(:users, :last_message)

        render json: @chats, include: [users: {methods: :avatar_attachment}, last_message: {only: [:content]}]
    end

    private

    def current_user
        @current_user ||= User.where(username: 'Protagonist').first
    end
end
