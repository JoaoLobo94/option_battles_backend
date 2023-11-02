class User < ApplicationRecord
  belongs_to :game, optional: true
  has_many :invoices
end
