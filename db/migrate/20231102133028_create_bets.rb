class CreateBets < ActiveRecord::Migration[7.1]
  def change
    create_table :bets do |t|
      t.float :amount
      t.string :bet, null: false
      t.check_constraint "bet IN ('up', 'down')"

      t.references :user, foreign_key: true, index: true
      t.references :game, foreign_key: true, index: true
      t.timestamps
    end
  end
end
