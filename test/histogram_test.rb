require 'minitest/autorun'

require_relative '../lib/distribution'

class TestHistogram < MiniTest::Unit::TestCase
	def setup
		@hist = Distribution::Histogram.new data:[-1,2,3,4,5,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,8,9,10,11,7,7,7,7,7,7,7]
	end

	def test_gen
		assert_equal @hist.gen.class, GSL::Histogram
	end

	def test_plot
		assert @hist.respond_to?(:plot)
	end

	def test_mean
		@hist.gen
		assert_equal @hist.mean.round(3),6.476
	end
end