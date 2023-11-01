class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.float :amount, null: false
      t.string :winner

      t.timestamps
    end
  end
end
