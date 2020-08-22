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
end
