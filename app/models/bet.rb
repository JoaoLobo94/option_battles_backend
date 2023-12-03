# == Schema Information
#
# Table name: bets
#
#  id         :bigint           not null, primary key
#  amount     :float(24)
#  bet        :string(255)      not null
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Bet < ApplicationRecord
  belongs_to :user

  def check_for_option_game_winner
    ws_url = 'wss://stream.binance.com:9443/ws/btcusdt@trade'

    EM.run do
      ws = WebSocket::EventMachine::Client.connect(uri: ws_url)

      ws.onopen do
        puts 'WebSocket connection opened'
      end

      ws.onmessage do |msg, type|
        handle_message(ws, msg)
      end

      ws.onclose do |code, reason|
        puts "WebSocket connection closed with code: #{code}, reason: #{reason}"
        EM.stop
      end
    end
  end

  private

  def handle_message(ws, msg)
    data = JSON.parse(msg)
    price = data['p'].to_f

    if (bet_type == 'up' && price > start_price) || (bet_type == 'down' && price < start_price)
      update(winner: true)
      user.update(balance: user.balance + amount * 2)
    else
      user.update(balance: user.balance - amount)
    end

    ws.close
  end

end

