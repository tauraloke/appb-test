json.array! @chats do |chat|
  json.id chat.id
  json.created_at chat.created_at
  json.updated_at chat.updated_at
  json.title chat.title
  json.last_message do |message|
    json.id chat.last_message_id
    json.content chat&.last_message&.content
  end
  json.users_except_me chat.users_except(@current_user) do |user|
    json.id user.id
    json.created_at user.created_at
    json.username user.username
    json.avatar_url user.avatar_attachment
  end
  json.unread_messages_count chat.unread_messages_count_of_user(@current_user)
end
