class ChatMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  validates :content, length: { maximum: 140 }
end