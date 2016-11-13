require 'spec_helper'

describe ExciseTaxJp do
  it 'has a version number' do
    expect(ExciseTaxJp::VERSION).not_to be nil
  end

  describe ".excise_tax_rate" do
    where(:date, :rate) do
      [
        [Date.new(1989, 3, 31), 0],
        [Date.new(1989, 4, 1),  BigDecimal("1.03")],
        [Date.new(1997, 3, 31), BigDecimal("1.03")],
        [Date.new(1997, 4, 1),  BigDecimal("1.05")],
        [Date.new(2014, 3, 31), BigDecimal("1.05")],
        [Date.new(2014, 4, 1),  BigDecimal("1.08")]
      ]
    end

    with_them do
      subject { ExciseTaxJp.excise_tax_rate(date: date) }

      it { is_expected.to eq rate }
    end
  end

  describe Integer do
    def integer_test_cases
      [
        # 8% & floor
        [10,   Date.new(2016, 1, 1), nil, 10],
        [20,   Date.new(2016, 1, 1), nil, 21],
        [30,   Date.new(2016, 1, 1), nil, 32],
        [40,   Date.new(2016, 1, 1), nil, 43],
        [50,   Date.new(2016, 1, 1), nil, 54],
        [60,   Date.new(2016, 1, 1), nil, 64],
        [70,   Date.new(2016, 1, 1), nil, 75],
        [80,   Date.new(2016, 1, 1), nil, 86],
        [90,   Date.new(2016, 1, 1), nil, 97],
        [100,  Date.new(2016, 1, 1), nil, 108],
        [198,  Date.new(2016, 1, 1), nil, 213],
        [0,    Date.new(2016, 1, 1), nil, 0],
        [-100, Date.new(2016, 1, 1), nil, -100],

        # %8 & round
        [10,   Date.new(2016, 1, 1), :round, 11],
        [20,   Date.new(2016, 1, 1), :round, 22],
        [30,   Date.new(2016, 1, 1), :round, 32],
        [40,   Date.new(2016, 1, 1), :round, 43],
        [50,   Date.new(2016, 1, 1), :round, 54],
        [60,   Date.new(2016, 1, 1), :round, 65],
        [70,   Date.new(2016, 1, 1), :round, 76],
        [80,   Date.new(2016, 1, 1), :round, 86],
        [90,   Date.new(2016, 1, 1), :round, 97],
        [100,  Date.new(2016, 1, 1), :round, 108],
        [198,  Date.new(2016, 1, 1), :round, 214],
        [0,    Date.new(2016, 1, 1), :round, 0],
        [-100, Date.new(2016, 1, 1), :round, -100],

        # %8 & ceil
        [10,   Date.new(2016, 1, 1), :ceil, 11],
        [20,   Date.new(2016, 1, 1), :ceil, 22],
        [30,   Date.new(2016, 1, 1), :ceil, 33],
        [40,   Date.new(2016, 1, 1), :ceil, 44],
        [50,   Date.new(2016, 1, 1), :ceil, 54],
        [60,   Date.new(2016, 1, 1), :ceil, 65],
        [70,   Date.new(2016, 1, 1), :ceil, 76],
        [80,   Date.new(2016, 1, 1), :ceil, 87],
        [90,   Date.new(2016, 1, 1), :ceil, 98],
        [100,  Date.new(2016, 1, 1), :ceil, 108],
        [198,  Date.new(2016, 1, 1), :ceil, 214],
        [0,    Date.new(2016, 1, 1), :ceil, 0],
        [-100, Date.new(2016, 1, 1), :ceil, -100],

        # 5% & floor
        [11,   Date.new(2014, 1, 1), nil, 11],
        [21,   Date.new(2014, 1, 1), nil, 22],
        [31,   Date.new(2014, 1, 1), nil, 32],
        [41,   Date.new(2014, 1, 1), nil, 43],
        [51,   Date.new(2014, 1, 1), nil, 53],
        [61,   Date.new(2014, 1, 1), nil, 64],
        [71,   Date.new(2014, 1, 1), nil, 74],
        [81,   Date.new(2014, 1, 1), nil, 85],
        [91,   Date.new(2014, 1, 1), nil, 95],
        [101,  Date.new(2014, 1, 1), nil, 106],
        [198,  Date.new(2014, 1, 1), nil, 207],
        [0,    Date.new(2014, 1, 1), nil, 0],
        [-100, Date.new(2014, 1, 1), nil, -100],

        # 5% & round
        [11,   Date.new(2014, 1, 1), :round, 12],
        [21,   Date.new(2014, 1, 1), :round, 22],
        [31,   Date.new(2014, 1, 1), :round, 33],
        [41,   Date.new(2014, 1, 1), :round, 43],
        [51,   Date.new(2014, 1, 1), :round, 54],
        [61,   Date.new(2014, 1, 1), :round, 64],
        [71,   Date.new(2014, 1, 1), :round, 75],
        [81,   Date.new(2014, 1, 1), :round, 85],
        [91,   Date.new(2014, 1, 1), :round, 96],
        [101,  Date.new(2014, 1, 1), :round, 106],
        [198,  Date.new(2014, 1, 1), :round, 208],
        [0,    Date.new(2014, 1, 1), :round, 0],
        [-100, Date.new(2014, 1, 1), :round, -100],

        # 5% & ceil
        [11,   Date.new(2014, 1, 1), :ceil, 12],
        [21,   Date.new(2014, 1, 1), :ceil, 23],
        [31,   Date.new(2014, 1, 1), :ceil, 33],
        [41,   Date.new(2014, 1, 1), :ceil, 44],
        [51,   Date.new(2014, 1, 1), :ceil, 54],
        [61,   Date.new(2014, 1, 1), :ceil, 65],
        [71,   Date.new(2014, 1, 1), :ceil, 75],
        [81,   Date.new(2014, 1, 1), :ceil, 86],
        [91,   Date.new(2014, 1, 1), :ceil, 96],
        [101,  Date.new(2014, 1, 1), :ceil, 107],
        [198,  Date.new(2014, 1, 1), :ceil, 208],
        [0,    Date.new(2014, 1, 1), :ceil, 0],
        [-100, Date.new(2014, 1, 1), :ceil, -100],

        # 3% & floor
        [11,   Date.new(1997, 1, 1), nil, 11],
        [21,   Date.new(1997, 1, 1), nil, 21],
        [31,   Date.new(1997, 1, 1), nil, 31],
        [41,   Date.new(1997, 1, 1), nil, 42],
        [51,   Date.new(1997, 1, 1), nil, 52],
        [61,   Date.new(1997, 1, 1), nil, 62],
        [71,   Date.new(1997, 1, 1), nil, 73],
        [81,   Date.new(1997, 1, 1), nil, 83],
        [91,   Date.new(1997, 1, 1), nil, 93],
        [101,  Date.new(1997, 1, 1), nil, 104],
        [198,  Date.new(1997, 1, 1), nil, 203],
        [0,    Date.new(1997, 1, 1), nil, 0],
        [-100, Date.new(1997, 1, 1), nil, -100],

        # 3% & round
        [11,   Date.new(1997, 1, 1), :round, 11],
        [21,   Date.new(1997, 1, 1), :round, 22],
        [31,   Date.new(1997, 1, 1), :round, 32],
        [41,   Date.new(1997, 1, 1), :round, 42],
        [51,   Date.new(1997, 1, 1), :round, 53],
        [61,   Date.new(1997, 1, 1), :round, 63],
        [71,   Date.new(1997, 1, 1), :round, 73],
        [81,   Date.new(1997, 1, 1), :round, 83],
        [91,   Date.new(1997, 1, 1), :round, 94],
        [101,  Date.new(1997, 1, 1), :round, 104],
        [198,  Date.new(1997, 1, 1), :round, 204],
        [0,    Date.new(1997, 1, 1), :round, 0],
        [-100, Date.new(1997, 1, 1), :round, -100],

        # 3% & ceil
        [11,   Date.new(1997, 1, 1), :ceil, 12],
        [21,   Date.new(1997, 1, 1), :ceil, 22],
        [31,   Date.new(1997, 1, 1), :ceil, 32],
        [41,   Date.new(1997, 1, 1), :ceil, 43],
        [51,   Date.new(1997, 1, 1), :ceil, 53],
        [61,   Date.new(1997, 1, 1), :ceil, 63],
        [71,   Date.new(1997, 1, 1), :ceil, 74],
        [81,   Date.new(1997, 1, 1), :ceil, 84],
        [91,   Date.new(1997, 1, 1), :ceil, 94],
        [101,  Date.new(1997, 1, 1), :ceil, 105],
        [198,  Date.new(1997, 1, 1), :ceil, 204],
        [0,    Date.new(1997, 1, 1), :ceil, 0],
        [-100, Date.new(1997, 1, 1), :ceil, -100]
      ]
    end

    describe "#with_excise_tax" do
      where(:integer, :date, :fraction, :amount) do
        integer_test_cases
      end

      with_them do
        subject { integer.with_excise_tax(args) }

        let(:args) do
          {}.tap do |o|
            o[:date]     = date     if date
            o[:fraction] = fraction if fraction
          end
        end

        it { is_expected.to eq amount }
      end
    end

    describe "#excise_tax" do
      where(:integer, :date, :fraction, :amount) do
        integer_test_cases
      end

      with_them do
        subject { integer.excise_tax(args) }

        let(:args) do
          {}.tap do |o|
            o[:date]     = date     if date
            o[:fraction] = fraction if fraction
          end
        end

        it { is_expected.to eq amount - integer }
      end
    end
  end

  describe BigDecimal do
    def big_decimal_test_cases
      [
        # 8% & floor
        [BigDecimal.new("100000000000000"), Date.new(2016, 1, 1), nil, BigDecimal.new("108000000000000")],
        [BigDecimal.new("198000000000000"), Date.new(2016, 1, 1), nil, BigDecimal.new("213840000000000")],
        [BigDecimal.new("10.1"),            Date.new(2016, 1, 1), nil, BigDecimal.new("10")],
        [BigDecimal.new("90.9"),            Date.new(2016, 1, 1), nil, BigDecimal.new("98")],
        [BigDecimal.new("0"),               Date.new(2016, 1, 1), nil, BigDecimal.new("0")],
        [BigDecimal.new("-10000000000000"), Date.new(2016, 1, 1), nil, BigDecimal.new("-10000000000000")],

        # # %8 & round
        [BigDecimal.new("100000000000000"), Date.new(2016, 1, 1), :round, BigDecimal.new("108000000000000")],
        [BigDecimal.new("198000000000000"), Date.new(2016, 1, 1), :round, BigDecimal.new("213840000000000")],
        [BigDecimal.new("10.1"),            Date.new(2016, 1, 1), :round, BigDecimal.new("11")],
        [BigDecimal.new("90.9"),            Date.new(2016, 1, 1), :round, BigDecimal.new("98")],
        [BigDecimal.new("0"),               Date.new(2016, 1, 1), :round, BigDecimal.new("0")],
        [BigDecimal.new("-10000000000000"), Date.new(2016, 1, 1), :round, BigDecimal.new("-10000000000000")],

        # # %8 & ceil
        [BigDecimal.new("100000000000000"), Date.new(2016, 1, 1), :ceil, BigDecimal.new("108000000000000")],
        [BigDecimal.new("198000000000000"), Date.new(2016, 1, 1), :ceil, BigDecimal.new("213840000000000")],
        [BigDecimal.new("10.1"),            Date.new(2016, 1, 1), :ceil, BigDecimal.new("11")],
        [BigDecimal.new("90.9"),            Date.new(2016, 1, 1), :ceil, BigDecimal.new("99")],
        [BigDecimal.new("0"),               Date.new(2016, 1, 1), :ceil, BigDecimal.new("0")],
        [BigDecimal.new("-10000000000000"), Date.new(2016, 1, 1), :ceil, BigDecimal.new("-10000000000000")],

        # # 5% & floor
        [BigDecimal.new("100000000000000"), Date.new(2014, 1, 1), nil, BigDecimal.new("105000000000000")],
        [BigDecimal.new("198000000000000"), Date.new(2014, 1, 1), nil, BigDecimal.new("207900000000000")],
        [BigDecimal.new("10.1"),            Date.new(2014, 1, 1), nil, BigDecimal.new("10")],
        [BigDecimal.new("90.9"),            Date.new(2014, 1, 1), nil, BigDecimal.new("95")],
        [BigDecimal.new("0"),               Date.new(2014, 1, 1), nil, BigDecimal.new("0")],
        [BigDecimal.new("-10000000000000"), Date.new(2014, 1, 1), nil, BigDecimal.new("-10000000000000")],

        # # 5% & round
        [BigDecimal.new("100000000000000"), Date.new(2014, 1, 1), :round, BigDecimal.new("105000000000000")],
        [BigDecimal.new("198000000000000"), Date.new(2014, 1, 1), :round, BigDecimal.new("207900000000000")],
        [BigDecimal.new("10.1"),            Date.new(2014, 1, 1), :round, BigDecimal.new("11")],
        [BigDecimal.new("90.9"),            Date.new(2014, 1, 1), :round, BigDecimal.new("95")],
        [BigDecimal.new("0"),               Date.new(2014, 1, 1), :round, BigDecimal.new("0")],
        [BigDecimal.new("-10000000000000"), Date.new(2014, 1, 1), :round, BigDecimal.new("-10000000000000")],

        # # 5% & ceil
        [BigDecimal.new("100000000000000"), Date.new(2014, 1, 1), :ceil, BigDecimal.new("105000000000000")],
        [BigDecimal.new("198000000000000"), Date.new(2014, 1, 1), :ceil, BigDecimal.new("207900000000000")],
        [BigDecimal.new("10.1"),            Date.new(2014, 1, 1), :ceil, BigDecimal.new("11")],
        [BigDecimal.new("90.9"),            Date.new(2014, 1, 1), :ceil, BigDecimal.new("96")],
        [BigDecimal.new("0"),               Date.new(2014, 1, 1), :ceil, BigDecimal.new("0")],
        [BigDecimal.new("-10000000000000"), Date.new(2014, 1, 1), :ceil, BigDecimal.new("-10000000000000")],

        # # 3% & floor
        [BigDecimal.new("100000000000000"), Date.new(1997, 1, 1), nil, BigDecimal.new("103000000000000")],
        [BigDecimal.new("198000000000000"), Date.new(1997, 1, 1), nil, BigDecimal.new("203940000000000")],
        [BigDecimal.new("10.1"),            Date.new(1997, 1, 1), nil, BigDecimal.new("10")],
        [BigDecimal.new("90.9"),            Date.new(1997, 1, 1), nil, BigDecimal.new("93")],
        [BigDecimal.new("0"),               Date.new(1997, 1, 1), nil, BigDecimal.new("0")],
        [BigDecimal.new("-10000000000000"), Date.new(1997, 1, 1), nil, BigDecimal.new("-10000000000000")],

        # # 3% & round
        [BigDecimal.new("100000000000000"), Date.new(1997, 1, 1), :round, BigDecimal.new("103000000000000")],
        [BigDecimal.new("198000000000000"), Date.new(1997, 1, 1), :round, BigDecimal.new("203940000000000")],
        [BigDecimal.new("10.1"),            Date.new(1997, 1, 1), :round, BigDecimal.new("10")],
        [BigDecimal.new("90.9"),            Date.new(1997, 1, 1), :round, BigDecimal.new("94")],
        [BigDecimal.new("0"),               Date.new(1997, 1, 1), :round, BigDecimal.new("0")],
        [BigDecimal.new("-10000000000000"), Date.new(1997, 1, 1), :round, BigDecimal.new("-10000000000000")],

        # # 3% & ceil
        [BigDecimal.new("100000000000000"), Date.new(1997, 1, 1), :ceil, BigDecimal.new("103000000000000")],
        [BigDecimal.new("198000000000000"), Date.new(1997, 1, 1), :ceil, BigDecimal.new("203940000000000")],
        [BigDecimal.new("10.1"),            Date.new(1997, 1, 1), :ceil, BigDecimal.new("11")],
        [BigDecimal.new("90.9"),            Date.new(1997, 1, 1), :ceil, BigDecimal.new("94")],
        [BigDecimal.new("0"),               Date.new(1997, 1, 1), :ceil, BigDecimal.new("0")],
        [BigDecimal.new("-10000000000000"), Date.new(1997, 1, 1), :ceil, BigDecimal.new("-10000000000000")]
      ]
    end

    describe "#with_excise_tax" do
      where(:big_decimal, :date, :fraction, :amount) do
        big_decimal_test_cases
      end

      with_them do
        subject { big_decimal.with_excise_tax(args) }

        let(:args) do
          {}.tap do |o|
            o[:date]     = date     if date
            o[:fraction] = fraction if fraction
          end
        end

        it { is_expected.to eq amount }
      end
    end

    describe "#excise_tax" do
      where(:big_decimal, :date, :fraction, :amount) do
        big_decimal_test_cases
      end

      with_them do
        subject { big_decimal.excise_tax(args) }

        let(:args) do
          {}.tap do |o|
            o[:date]     = date     if date
            o[:fraction] = fraction if fraction
          end
        end

        it { is_expected.to eq amount - big_decimal }
      end
    end
  end
end
