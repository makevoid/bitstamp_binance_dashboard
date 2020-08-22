class Balance

  def self.all
    new.all
  end

  def all
    balances =  MKVBinance.balances
    balances += MKVBitstamp.balances
    tickers = Ticker.all
    balances = apply_tickers tickers
    balances
  end

  def apply_tickers(tickers)
    balances.each do |bal|
      ticker = tickers.find{ |tick| "#{bal[:asset]}USD" == tick[:symbol] }
      price = ticker conversion: "BTC"
      bal[:btc] = price
      bal[:usd] = convert_usd price if price
      price = ticker conversion: "USD"
      bal[:usd] = price unless bal[:usd]
      bal
    end
  end

  def convert_usd

  end

end
