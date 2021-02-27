class Candle
  def self.asset(asset)
    new(asset: asset).candle
  end

  def initialize(asset:)
    @asset = asset
  end

  def candle_data_weekly
    one_day = 3600*24
    one_week = one_day * 7
    date = one_week
    Binance::Api.candlesticks! symbol: @asset, interval: "1d", startTime: (Time.now - date).to_i*1000
  end

  def candle_data_daily
    one_day = 3600*24
    date = one_day
    Binance::Api.candlesticks! symbol: @asset, interval: "1h", startTime: (Time.now - date).to_i*1000
  end

  def candle
    data = candle_data_weekly
    # data = candle_data_daily # uncomment/use this if you want 1 day range (x24 1h candles)
    data = pick_data data
    data = convert_data data
    convert_data_gchart data
  end

  private

  def pick_data(data)
    data.map do |candle|
      candle[0..4]
    end
  end

  def convert_data(data)
    data.map do |candle|
      [
        Time.at(candle[0]/1000).httpdate,
        candle[1].to_f,
        candle[2].to_f,
        candle[3].to_f,
        candle[4].to_f,
      ]
    end
  end

  # nonsense - gogle is sorting the columns
  # OHLC -> LOCH
  def convert_data_gchart(data)
    data.map do |candle|
      [
        candle[0],
        candle[3],
        candle[1],
        candle[4],
        candle[2],
      ]
    end
  end
end
