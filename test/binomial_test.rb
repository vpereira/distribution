require 'minitest/unit'
require 'minitest/autorun'

require_relative '../lib/distribution'

class TestBinomialDistribution1 < MiniTest::Unit::TestCase
    
    #test a loaded dice 
    def test_1_of_6
      d = Distribution::Binomial.new(6,[1],0.3)
      assert  GSL::equal?(d.pmf.first,0.30252599999)
      assert_equal d.mean,6*0.3
    end

    def test_random_variable
      d = Distribution::Binomial.new(6,[1,2,3,4,5],0.5)
      assert_equal d.pmf.class,GSL::Vector
    end

    def test_cdf
      d = Distribution::Binomial.new(6,[1,2,3,4,5,6],0.3)
      assert_equal d.cdf,GSL::Vector.alloc([0.4201749999999991, 0.7443100000000008, 0.9295300000000002, 0.989065, 0.999271, 1.0])
    end

    def test_pdf
      d = Distribution::Binomial.new(6,[1,2,3,4,5,6],0.3)
      assert_equal d.pdf, GSL::Vector.alloc([0.30252600000000013, 0.32413499999999995, 0.18522000000000008, 0.05953499999999999, 0.010206, 0.0007289999999999991])
    end
end


class TestBinomialDistribution2 < MiniTest::Unit::TestCase
  def setup
    @dist = Distribution::Binomial.new(10,[1,2,3,4,5,6],0.5)
  end

  def test_sigma
    assert_equal @dist.sigma,1.5811388300841898 
  end

  def test_mean
    assert_equal @dist.mean, 5.0 
  end
end