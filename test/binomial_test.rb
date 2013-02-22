require 'minitest/unit'
require 'minitest/autorun'

require_relative '../lib/distribution'

class TestBinomialDsitribution < MiniTest::Unit::TestCase
    
    #test a loaded dice 
    def test_1_of_6
      d = Distribution::Binomial.new(6,[1],0.3)
      assert  GSL::equal?(d.pmf.first,0.30252599999)
      assert_equal d.mean,6*0.3
    end

    def test_random_variable
      d = Distribution::Binomial.new(6,[1,2,3,4,5],0.5)
      assert_equal d.pmf.class,Array
    end

    def test_cdf
      d = Distribution::Binomial.new(6,[1,2,3,4,5,6],0.3)
      assert_equal d.cdf(3),[0.4201749999999991, 0.7443100000000008, 0.9295300000000002, 0.989065, 0.999271, 1.0]
    end
end
