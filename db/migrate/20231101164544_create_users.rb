class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.decimal :balance, precision: 10, scale: 2
      t.string :lnurl

      t.timestamps
    end
  end
end
