# for simplicity we use binance's data for ticker prices (even for bitstamp)

class Ticker

  def self.all
    Binance::Api.ticker! type: :price
  end

  def self.eur
    # Bitstamp.ticker # TODO: fix bitstamp gem
    new.bitstamp_eurusd
  end

  def bitstamp_eurusd
    ticker = bitstamp_eurusd_raw
    ticker = JSON.parse ticker
    ticker
  end

  def bitstamp_eurusd_raw
    bitstamp_ticker_raw symbol: "eurusd"
  end

  def bitstamp_ticker_raw(symbol:)
    Bitstamp::Net.get("/ticker/#{symbol}").body_str
  end


end
