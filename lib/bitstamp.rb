class MKVBitstamp

  def self.balances
    new.balances
  end

  def balances
    balances = bitstamp_balances
    balances = filter_bitstamp_balances balances
    #raise balances.inspect
    balances = filter_zero_balances balances
    add_exchange_tag balances: balances
  end

  private

  def bitstamp_balances
    resp = Bitstamp.balance
    error = resp["error"]
    raise "BitstampAPICredentialsError - error: #{error}" if error
    resp
  end

  def filter_bitstamp_balances(balances)
    balances.map do |key, val|
      asset = key.match(/(\w+)_balance/)
      asset = asset[1].upcase if asset
      {
        free: val,
        total: val,
        locked: 0,
        asset: asset,
      } if key =~ /_balance$/
    end.compact
  end

  def filter_zero_balances(balances)
    balances.select do |bal|
      total = bal[:free].to_f + bal[:locked].to_f
      bal if total > 0
    end
  end

  def add_exchange_tag(balances:)
    balances.map do |bal|
      bal[:exchange] = :bitstamp
      bal
    end
  end

end
