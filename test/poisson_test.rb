require 'minitest/unit'
require 'minitest/autorun'

require_relative '../lib/distribution'

class TestPoissonlDistribution < MiniTest::Unit::TestCase
	def setup
		@d = Distribution::Poisson.new(mean:5,k:[2])
	end

	def test_1
		assert_equal @d.skewness, 0.447
		assert_equal @d.kurtosis, 3.20
		assert_equal @d.pdf.first, 0.084
	end
	def test_histogram
    	@d.get_samples(1,2)
    	assert_equal @d.hist(@d.samples.first.cases).class, GSL::Histogram
  	end
end