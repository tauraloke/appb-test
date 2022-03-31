class ChatsController < ApplicationController
  api :GET, 'chats'
  desc 'Chats of a current user.'
  param :limit, :number, desc: 'limit of results', required: false
  param :offset, :number, desc: 'offset of a result page', required: false
  def index
    @chats = current_user.chats.limit(limit).offset(offset).order(updated_at: :desc)
  end
end
