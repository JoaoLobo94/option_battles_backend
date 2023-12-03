class CreateBets < ActiveRecord::Migration[7.1]
  def change
    create_table :bets do |t|
      t.float :amount
      t.string :bet_type, null: false
      t.boolean :winner, default: false
      t.decimal :win_price
      t.decimal :start_price

      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
  end
end
