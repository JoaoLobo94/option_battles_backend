class LiquidServer
  include HTTParty
  base_uri 'http://127.0.0.1:5000'
  def initialize(private_key: nil)
    @private_key = private_key ? private_key : ENV['LIQUID_PRIVATE_KEY_MAINNET']
    @liquid_token = ENV['LIQUID_PYTHON_TOKEN']
  end

  def headers
    { "Content-Type" => "application/json", "Authorization" => "#{@liquid_token}" }
  end
  def generate_address
    self.class.post("/api/v1/wallet/new-address", body: { mnemonic: @private_key }.to_json, headers: headers)
  end

  def wallet_balance
    self.class.post("/api/v1/wallet/balance", body: { mnemonic: @private_key }.to_json, headers: headers)
  end

  def send_to_address(address, amount, asset_id: nil)
    self.class.post("/api/v1/wallet/send-to-address", body: { mnemonic: @private_key,
                                                              asset_id: asset_id,
                                                              destination_address: address,
                                                              sat_amount: amount }.to_json,
                    headers: headers)
  end

  def wallet_transactions
    self.class.post("/api/v1/wallet/transactions", body: { mnemonic: @private_key }.to_json, headers: headers)
  end
end