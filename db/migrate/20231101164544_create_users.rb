class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :npub, null: false
      t.string :lnurl
      t.float :game_amount
      t.boolean :looking_for_game, default: true
      t.references :game, foreign_key: true, index: true

      t.timestamps
    end
  end
end
