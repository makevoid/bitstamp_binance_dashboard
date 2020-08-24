class Balance

  def self.all
    new.all
  end

  def all
    balances =  MKVBinance.balances
    balances += MKVBitstamp.balances
    balances = sort_move_eur_last balances: balances
    tickers = Ticker.all
    balances = apply_tickers tickers, balances: balances
    balances
  end

  def apply_tickers(tickers, balances:)
    balances.map do |bal|
      apply_tickers_to_balance bal, balances: balances, tickers: tickers
    end
  end

  def apply_tickers_to_balance(bal, balances:, tickers:)
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
    if bal[:asset] == "EUR" # bitstamp
      conv = ticker_eur
      price_eur = total * conv
      bal[:usd] = price_eur
    end
    if bal[:asset] == "USD" # bitstamp
      bal[:usd] = total
    end
    bal
  end

  def sort_move_eur_last(balances:)
    idx = balances.find_index { |bal| bal[:asset] == "EUR" }
    return balances unless idx
    eur = balances.delete_at idx
    balances << eur
    balances
  end

  def ticker_eur
    @ticker_eur ||= (Ticker.eur.fetch "last").to_f / 10000
  end

  def ticker_usd(tickers:)
    @ticker_usd ||= ticker tickers: tickers, conversion: "USDT", asset: "BTC" # usdt as usd is not available on binance
  end

  def ticker(tickers:, asset:, conversion:)
    tick = tickers.find{ |tick| "#{asset}#{conversion}" == tick[:symbol] }
    tick && tick[:price].to_f
  end

end
