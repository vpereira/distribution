
require 'minitest/autorun'

require_relative '../lib/distribution'

class TestNormalDsitribution < MiniTest::Unit::TestCase

	def setup
		@d = Distribution::Normal.new(x:[1,2,3,4])
	end

  def test_results
      assert_equal @d.pdf, GSL::Vector.alloc([0.242, 0.054, 0.004, 0.000])
      assert_equal @d.cdf, GSL::Vector.alloc([0.841, 0.977, 0.999, 1.000])
      assert_equal @d.get_cases(10,10).length, 10 * 10 
  end

  def test_histogram
    	@d.get_samples(10,30)
      assert_instance_of GSL::Histogram,@d.hist
  end

  def test_samples
      @d.get_samples(1,10)
      assert_instance_of Array, @d.samples
      assert_instance_of Distribution::Sample, @d.samples.first
      assert_equal @d.samples.first.distribution,:normal
  end
  
end
