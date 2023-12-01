class Lightning
  include HTTParty
  base_uri 'https://api.getalby.com'
  def initialize
    @secret_key = ENV['SECRET_KEY']
  end

  def create_invoice(amount)
    self.class.post("/invoices", body: { amount: amount }.to_json, headers: { "Authorization" => "Bearer #{@secret_key}", "Content-Type" => "application/json" })
  end

  def pay_invoice(invoice)
    self.class.post("/payments/bolt11", body: { out: 'lnurl', bolt11: invoice }, headers: { "X-Api-Key" => @secret_key })
  end

  def get_invoice_status(payment_hash)
    self.class.get("/invoices/#{payment_hash}", headers: { "Authorization" => "Bearer #{@secret_key}", "Content-Type" => "application/json" })
  end
end