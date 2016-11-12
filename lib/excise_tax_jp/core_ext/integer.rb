class Integer
  def with_excise_tax(date: Date.current, fraction: :floor)
    return self if self < 0

    (BigDecimal(self) * ExciseTaxJp.excise_tax_rate(date: date)).__send__(fraction)
  end

  def with_excise_tax!(date: Date.current, fraction: :floor)
    self.replace(with_excise_tax(date: date, fraction: fraction))
  end

  def excise_tax(date: Date.current, fraction: :floor)
    with_excise_tax(date: date, fraction: fraction) - self
  end
end
