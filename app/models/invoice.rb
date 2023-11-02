class Invoice < ApplicationRecord
  belongs_to :user

  def self.pay_winner
    user =  User.find(user_id)
    if user.npub == user.game.winner
      Lightning.new.transfer_funds(user.game.amount, user.lnurl )
      'You are the winner'
    else
      'You are not the winner'
    end
  end
end