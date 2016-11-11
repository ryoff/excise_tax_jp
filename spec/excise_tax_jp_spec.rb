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
          [1000, Date.new(2016, 1, 1), nil, 1080]
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
