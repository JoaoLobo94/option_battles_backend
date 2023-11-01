class Invoice < ApplicationRecord
  belongs_to :user

  def self.pay_winner(invoice_code)
    user =  User.find(user_id)
    if user.npub == user.game.winner
      Lightning.new.pay_invoice(invoice_code)
      'You are the winner'
    else
      'You are not the winner'
    end
  end
end