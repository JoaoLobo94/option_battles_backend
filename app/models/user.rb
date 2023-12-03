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
end
