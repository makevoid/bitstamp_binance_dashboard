# for simplicity we use binance's data for ticker prices (even for bitstamp)

class Ticker

  def self.all
    Binance::Api.ticker! type: :price
  end

end
