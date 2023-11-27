class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.boolean :paid, default: false
      t.text :invoice_code
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
