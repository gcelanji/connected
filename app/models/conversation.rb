class Conversation < ApplicationRecord
  has_many :conversation_users, dependent: :destroy
  has_many :users, through: :conversation_users
  has_many :messages, dependent: :destroy

  def self.between(user_ids)
    joins(:conversation_users)
      .where(conversation_users: { user_id: user_ids })
      .group('conversations.id')
      .having('COUNT(conversation_users.user_id) = ?', user_ids.size)
      .first
  end
end
