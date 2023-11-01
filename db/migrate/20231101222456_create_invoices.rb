class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.float :amount
      t.boolean :paid, default: false
      t.string :invoice_code
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
