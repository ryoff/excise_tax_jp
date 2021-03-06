class BigDecimal
  def with_excise_tax(date: Date.today, fraction: :floor)
    return self if self < 0

    (self * ExciseTaxJp.excise_tax_rate(date: date)).__send__(fraction)
  end

  # return only excise_tax
  def excise_tax(date: Date.today, fraction: :floor)
    with_excise_tax(date: date, fraction: fraction) - self
  end
end
