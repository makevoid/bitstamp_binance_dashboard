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
      total = bal[:total].to_f
      conv = ticker tickers: tickers, conversion: "BTC", asset: bal[:asset]
      if conv
        price = total * conv
        bal[:btc] = price
      end
      if conv || bal[:asset] == "BTC"
        price = total if bal[:asset] == "BTC"
        conv = ticker_usd tickers: tickers
        price_usd = price * conv if conv
        bal[:usd] = price_usd
      end
      bal
    end
  end

  def ticker_usd(tickers:)
    @ticker_usd ||= ticker tickers: tickers, conversion: "USDT", asset: "BTC" # usdt as usd is not available on binance
  end

  def ticker(tickers:, asset:, conversion:)
    tick = tickers.find{ |tick| "#{asset}#{conversion}" == tick[:symbol] }
    tick && tick[:price].to_f
  end

end
