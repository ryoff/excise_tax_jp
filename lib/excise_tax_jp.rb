require "bigdecimal"
require "date"
require "excise_tax_jp/version"
require "excise_tax_jp/core_ext/integer"
require "excise_tax_jp/core_ext/bigdecimal"

module ExciseTaxJp
  RATE103 = BigDecimal("1.03").freeze
  RATE105 = BigDecimal("1.05").freeze
  RATE108 = BigDecimal("1.08").freeze

  class << self
    def excise_tax_rate(date: Date.today)
      # https://github.com/ruby/ruby/commit/337a3da71cd3c7e98d9c11b1f58e53049489dacf
      if (Date.new(1989, 4, 1)..Date.new(1997, 3, 31)).cover?(date)
        ExciseTaxJp::RATE103
      elsif (Date.new(1997, 4, 1)..Date.new(2014, 3, 31)).cover?(date)
        ExciseTaxJp::RATE105
      elsif (Date.new(2014, 4, 1)..Date::Infinity.new).cover?(date)
        ExciseTaxJp::RATE108
      else
        0
      end
    end
  end
end
