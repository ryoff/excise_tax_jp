# ExciseTaxJp

日本の消費税計算gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'excise_tax_jp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install excise_tax_jp

## Usage

```
# latest japanese excise tax rate
ExciseTaxJp.excise_tax_rate # => #<BigDecimal:7f9b84ab6cc0,'0.108E1',18(18)>
198.with_excise_tax         # => 213
198.excise_tax              # => 15

# using old rate (default: Date.current)
ExciseTaxJp.excise_tax_rate(date: Date.new(1997, 1, 1)) # => #<BigDecimal:7f9b84ab6e28,'0.103E1',18(18)>
198.with_excise_tax(date: Date.new(1997, 1, 1))         # => 203
198.excise_tax(date: Date.new(1997, 1, 1))              # => 5

# using rounding (default: :floor)
198.excise_tax                   # => 15
198.excise_tax(fraction: :round) # => 16
198.excise_tax(fraction: :ceil)  # => 16

# big decimal
BigDecimal("10000000000000").with_excise_tax # => 10800000000000
BigDecimal("10000000000000").excise_tax      # => #<BigDecimal:7f9b842ee740,'0.8E12',9(18)>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/excise_tax_jp. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
