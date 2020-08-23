class Balance

  def self.all
    new.all
  end

  def all
    balances =  MKVBinance.balances
    balances += MKVBitstamp.balances
    tickers = Ticker.all
    balances = apply_tickers tickers, balances: balances
    balances
  end

  def apply_tickers(tickers, balances:)
    balances.map do |bal|
      conv = ticker tickers: tickers, conversion: "BTC", asset: bal[:asset]
      if conv
        price = bal[:total].to_f * conv
        bal[:btc] = price
        conv = ticker tickers: tickers, conversion: "USDT", asset: "BTC" # usdt as usd is not available on binance
        price_usd = price * conv if conv
        bal[:usd] = price_usd
      end
      bal
    end
  end

  def ticker(tickers:, asset:, conversion:)
    tick = tickers.find{ |tick| "#{asset}#{conversion}" == tick[:symbol] }
    tick && tick[:price].to_f
  end

end
