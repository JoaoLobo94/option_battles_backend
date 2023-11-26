# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  npub       :string(255)      not null
#  lnurl      :string(255)
#  game_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  belongs_to :game, optional: true
  has_many :invoices
  has_many :bets
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :lnurl, presence: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\z/, message: 'Invalid lnurl format' }
end
