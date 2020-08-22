# for simplicity we use binance's data for ticker prices (even for bitstamp)
# 
# r.root {
#   balances  = Balance.all
#   balances  = Ticker.hydrate balances: balances
#   @balances = balances
#   view 'index'
# }

class Ticker

  def self.hydrate(balances)
    new(balances: balances).hydrate
  end

  def initialize(balances:)
    @balances = balances
  end

  def hydrate
    tickers symbols: []
  end

  def tickers(symbols:)
    ticker = Binance::Api.ticker!  type: :price
    ticker
  end

end
