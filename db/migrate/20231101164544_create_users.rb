class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :npub
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :lnurl
      t.references :game, foreign_key: true, index: true

      t.timestamps
    end
  end
end
