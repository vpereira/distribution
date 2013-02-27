# Distribution

Playing with ruby science. Fooling around with some distributions. Until now nothing serious

## Installation

Add this line to your application's Gemfile:

    gem 'distribution'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install distribution

other requirements: gnu plotutls.  

For mac you can install it with the command:

    brew install plotutils

For linux probably there is a package as well.

## Usage

### Normal Distribution

    d = Distribution::Normal.new([1,2,3,4])
    d.pdf # => [0.24197072451914337, 0.05399096651318806, 0.0044318484119380075, 0.00013383022576488537]
    d.get_samples(10,30) # 10 samples with 30 cases each without replacement and discrete
    d.get_samples(10,30,true,:continuous) #10 samples with 30 cases each, with replacement and continuous
    d.samples # Array of Sample objects
    
### Binomial Distribution

    d = Distribution::Binomial.new(n=6,k=1,p=0.3)
    d.pmf # [0.30252599999]
    d.cdf(3) #P(X<=3)
    # => [0.4201749999999991, 0.7443100000000008, 0.9295300000000002, 0.989065, 0.999271, 1.0]
    d.symmetric? #=> false
    d.to_report
    # trials:6
    # random variable 0.000e+00
    # probability of successes: 0.3
    # mean: 1.7999999999999998
    # standard deviation: 1.7146428199482244
    # skewness: 0.23328473740792177
    # kurtosis 2.793650793650794

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
