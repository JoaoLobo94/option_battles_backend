# == Schema Information
#
# Table name: bets
#
#  id         :bigint           not null, primary key
#  amount     :float(24)
#  bet        :string(255)      not null
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :game
end
