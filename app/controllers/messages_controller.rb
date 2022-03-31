class MessagesController < ApplicationController
  api :GET, 'chats/:id/messages'
  desc 'List of messages in a chat.'
  param :chat_id, :number, desc: 'chat identifier', required: true
  param :limit, :number, desc: 'limit of results', required: false
  param :offset, :number, desc: 'offset of a result page', required: false
  def index
    @messages = chat.messages.includes(:user).limit(limit).offset(offset).order(created_at: :asc)
  end

  private

  def chat
    @chat ||= current_user.chats.find(params[:chat_id])
  end
end
