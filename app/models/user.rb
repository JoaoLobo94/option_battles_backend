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
end
