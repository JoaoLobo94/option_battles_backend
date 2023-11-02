class Lightning
  include HTTParty
  base_uri 'https://api.lnpay.co/v1'
  def initialize
    @secret_key = ENV['SECRET_KEY']
    @wallet_key = ENV['WALLET_KEY']
  end

  def retrieve_wallet(wallet_id)
    self.class.get("/wallet/#{wallet_id}", headers: { "X-Api-Key" => @secret_key })
  end

  def create_invoice(amount, memo)
    self.class.post("/wallet/#{@wallet_key}/invoice", body: { num_satoshis: amount, memo: memo }, headers: { "X-Api-Key" => @secret_key })
  end

  def pay_invoice(invoice)
    self.class.post("/wallet/#{@wallet_key}/withdraw", body: { out: 'lnurl', bolt11: invoice }, headers: { "X-Api-Key" => @secret_key })
  end

  def transfer_funds(amount, lnurlpay_encoded)
    self.class.post("/wallet/#{@wallet_key}/lnurlp/pay", body: { amt_msat: amount, ln_url: lnurlpay_encoded  }, headers: { "X-Api-Key" => @secret_key })

  end

  def get_invoice_status(invoice)
    self.class.get("/lntx/#{invoice}", headers: { "X-Api-Key" => @secret_key })
  end
end