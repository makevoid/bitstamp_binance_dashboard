class MKVBinance

  def self.balances
    new.balances
  end

  def balances
    balances = info.fetch :balances
    balances = filter_useless_coins balances: balances
    balances = sum_total balances: balances
    balances = filter_zero_balances balances
    add_exchange_tag balances: balances
  end

  private

  def info
    Binance::Api::Account.info!
  end

  USELESS_COINS = %w(
    EDO
    JEX
  )

  def filter_useless_coins(balances:)
    balances.reject do |bal|
      bal if USELESS_COINS.include? bal[:asset]
    end
  end

  def filter_zero_balances(balances)
    balances.select do |bal|
      bal if bal[:total] > 0
    end
  end

  def add_exchange_tag(balances:)
    balances.map do |bal|
      bal[:exchange] = :binance
      bal
    end
  end

  def sum_total(balances:)
    balances.map do |bal|
      total = bal[:free].to_f + bal[:locked].to_f
      bal[:total] = total
      bal
    end
  end

end
