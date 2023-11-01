class User < ApplicationRecord
  belongs_to :game, optional: true
  has_many :invoices

  def self.looking_for_same_game(game_amount)
    where(game_amount: game_amount) - User.where(looking_for_game: false)
  end
end
