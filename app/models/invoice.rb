# == Schema Information
#
# Table name: invoices
#
#  id           :bigint           not null, primary key
#  amount       :float(24)
#  paid         :boolean          default(FALSE)
#  invoice_code :string(255)
#  user_id      :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
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
