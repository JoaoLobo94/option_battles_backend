# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  balance         :decimal(10, 2)
#  lnurl           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_many :invoices
  has_many :bets
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :lnurl, presence: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\z/, message: 'Invalid lnurl format' }


  def withdraw(bolt11)
    invoice = Lightning.decode_invoice(bolt11)
    if invoice['msatoshi'].to_i / 1000 <= self.balance
      self.balance -= invoice['msatoshi'].to_i / 1000
      Lightning.pay_invoice(bolt11)
    else
      "Insufficient funds"
    end
    save
  end
end
