class MKVBitstamp

  def self.balances
    new.balances
  end

  def balances
    # balances = info.fetch :balances
    balances = []
    balances = filter_zero_balances balances
    add_exchange_tag balances: balances
  end

  private

  def filter_zero_balances(balances)
    balances.select do |bal|
      total = bal[:free].to_f + bal[:locked].to_f
      bal if total > 0
    end
  end

  def add_exchange_tag(balances:)
    balances.map do |bal|
      bal[:exchange] = :binance
      bal
    end
  end

end
