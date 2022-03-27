json.array! @messages do |message|
    json.id message.id
    json.created_at message.created_at
    json.updated_at message.updated_at
    json.content message.content
    json.user_id message.user_id
    json.username message.user&.username
    json.avatar_url message.user&.avatar_attachment
    json.viewed_by message.message_viewers.select(:user_id).pluck(:user_id)
end