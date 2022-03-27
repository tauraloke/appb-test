class ApplicationController < ActionController::Base
  private

  DEFAULT_LIMIT = 10
  DEFAULT_OFFSET = 0

  def current_user
    @current_user ||= User.where(username: 'Protagonist').first
  end

  def limit
    @limit ||= params[:limit] || DEFAULT_LIMIT
  end

  def offset
    @offset ||= params[:offset] || DEFAULT_OFFSET
  end
end
