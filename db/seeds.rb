# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Chat.destroy_all
ChatParticipant.destroy_all
Message.destroy_all
MessageViewer.destroy_all

users = User.create([{ username: 'Protagonist' }, { username: 'Antagonist' }])
chats = Chat.create([{ title: nil }])
ChatParticipant.create([
                         {
                           user_id: users[0].id,
                           chat_id: chats[0].id,
                           unread_messages_count: 1
                         },
                         {
                           user_id: users[1].id,
                           chat_id: chats[0].id
                         }
                       ])
messages = Message.create([
                            { user_id: users[0].id, chat_id: chats[0].id, content: 'First message' },
                            { user_id: users[1].id, chat_id: chats[0].id, content: 'Second message' }
                          ])
chats[0].update(last_message_id: messages[1].id)
MessageViewer.create([{ user_id: users[1].id, message_id: messages[0].id }])
