require 'minitest/unit'
require 'minitest/autorun'

require_relative '../lib/distribution'

class TestBinomialDistribution1 < MiniTest::Unit::TestCase
    
    #test a loaded dice 
    def test_1_of_6
      d = Distribution::Binomial.new(n:6,k:[1],p:0.3)
      assert_equal  d.pmf.first, 0.303
      assert_equal d.mean,6*0.3
    end

end

class TestBinomialDistribution3 < MiniTest::Unit::TestCase
  def setup
      @d = Distribution::Binomial.new(n:6,k:[1,2,3,4,5,6],p:0.3)
  end

  def test_cdf
    assert_equal @d.cdf,GSL::Vector.alloc([0.420, 0.744, 0.930, 0.989, 0.999, 1.0])
  end

  def test_pdf
    assert_equal @d.pdf, GSL::Vector.alloc([0.303, 0.324, 0.185, 0.060, 0.0100, 0.001])
  end
  
  def test_random_variable
    assert_instance_of GSL::Vector,@d.pmf
  end
  
end

class TestBinomialDistribution2 < MiniTest::Unit::TestCase
  def setup
    @dist = Distribution::Binomial.new(n:10,p:0.5)
  end

  def test_sigma
    assert_equal @dist.sigma,1.5811388300841898 
  end

  def test_mean
    assert_equal @dist.mean, 5.0 
  end

  def symmetric
    assert @dist.symmetric?
  end

  def test_histogram
      @dist.get_samples(10,30)
      assert_instance_of GSL::Histogram,@dist.hist
  end
end