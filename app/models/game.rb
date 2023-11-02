# == Schema Information
#
# Table name: games
#
#  id          :bigint           not null, primary key
#  amount      :float(24)        not null
#  in_progress :boolean          default(FALSE)
#  winner      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Game < ApplicationRecord
  has_many :users
end
