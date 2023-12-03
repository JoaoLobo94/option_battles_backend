# == Schema Information
#
# Table name: invoices
#
#  id           :bigint           not null, primary key
#  amount       :float(24)
#  paid         :boolean          default(FALSE)
#  invoice_code :string(255)
#  user_id      :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Invoice < ApplicationRecord
  belongs_to :user
end
