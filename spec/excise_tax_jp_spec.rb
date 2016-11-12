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
    describe "#with_excise_tax" do
      where(:integer, :date, :fraction, :amount) do
        [
          # 8%
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
        ]
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
  end
end
