class BoltzExchange
  include HTTParty
  base_uri 'https://api.boltz.exchange/'
  def initialize
    @private_key = ENV['LIQUID_WALLET']
    @liquid_token = ENV['LIQUID_PYTHON_TOKEN']

  end
end