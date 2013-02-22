# Distribution

Playing with ruby science. Fooling around with some distributions. Until now nothing serious

## Installation

Add this line to your application's Gemfile:

    gem 'distribution'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install distribution

## Usage

### Normal Distribution

    d = Distribution::Normal.new([1,2,3,4])
    d.pdf # [0.24197072451914337, 0.05399096651318806, 0.0044318484119380075, 0.00013383022576488537]

### Binomial Distribution

    d = Distribution::Binomial.new(6,1,0.3)
    d.pmf # [0.30252599999]
    d.cdf(3) #P(X<=3)
    #[0.4201749999999991, 0.7443100000000008, 0.9295300000000002, 0.989065, 0.999271, 1.0]


1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
