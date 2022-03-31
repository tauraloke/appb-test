class MessagesController < ApplicationController
  def index
    @messages = chat.messages.includes(:user).limit(limit).offset(offset).order(created_at: :asc)
  end

  private

  def chat
    @chat ||= current_user.chats.find(params[:chat_id])
  end
end
