class MessagesController < ApplicationController
  api :GET, 'chats/:id/messages'
  desc 'List of messages in a chat.'
  param :chat_id, :number, desc: 'chat identifier'
  param :limit, :number, desc: 'limit of results'
  param :offset, :number, desc: 'offset of a result page'
  def index
    @messages = chat.messages.includes(:user).limit(limit).offset(offset).order(created_at: :asc)
  end

  api :POST, 'chats/:id/messages'
  desc 'Add a new message to the chat.'
  param :chat_id, :number, desc: 'chat identifier'
  param :content, String, desc: 'message text'
  def create
    ActiveRecord::Base.transaction do
      @message = chat.messages.create({
                                        user_id: current_user.id,
                                        content: content
                                      })
      chat.chat_participants
          .where
          .not(user_id: current_user.id)
          .update_all('unread_messages_count = unread_messages_count + 1')
    end

    render json: { message: @message, status: 'OK' }
  end

  api :PUT, 'chats/:id/messages/mark_as_read'
  desc 'Mark messages as read by ids.'
  param :chat_id, :number, desc: 'chat identifier'
  param :ids, Array, of: :number, desc: 'message identifiers'
  def mark_as_read
    message_ids_to_marking = chat.messages
                                 .where
                                 .not(user_id: current_user.id)
                                 .where(id: ids)
                                 .select(:id)
                                 .pluck(:id)
    ActiveRecord::Base.transaction do
      chat.chat_participant_by_user(current_user)
          .decrement!(:unread_messages_count, message_ids_to_marking.size)

      MessageViewer.create(message_ids_to_marking.map do |message_id|
        {
          message_id: message_id,
          user_id: current_user.id
        }
      end)
    end
    render json: { status: 'OK' }
  end

  private

  def chat
    @chat ||= current_user.chats.find(params[:chat_id])
  end

  def ids
    @ids ||= params[:ids] || []
  end

  def content
    @content ||= params[:content]
  end
end
