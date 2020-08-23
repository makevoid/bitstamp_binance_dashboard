module ViewHelpers
  # def labelize(string)
  #   Inflecto.humanize(Inflecto.underscore(string.to_s)).capitalize
  # end

  def fmt(num)
    int, dec = num.to_s.split(".")
    dec = ".#{dec[0..3]}" if dec
    dec = "" if dec.to_f == 0
    "#{int}#{dec}"
  end

  def fmt2(num)
    '%.2f' % num
  end

  def icon_url(asset:)
    if asset == "PNT"
      "/img/icons/pnt.png"
    else
      spothq_icon_url asset
    end
  end

  private

  def spothq_icon_url(asset)
    "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/32/icon/#{asset.downcase}.png"
  end

end
