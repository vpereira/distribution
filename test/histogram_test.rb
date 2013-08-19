require 'minitest/autorun'

require_relative '../lib/distribution'

class TestHistogram < MiniTest::Unit::TestCase
	def setup
		@hist = Distribution::Histogram.new data:[-1,2,3,4,5,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,8,9,10,11,7,7,7,7,7,7,7]
	end

	#def test_gen
	#	assert_instance_of GSL::Histogram,@hist.gen
	#end

	def test_plot
		assert_respond_to @hist,:plot
	end


	def test_exception_mean
		assert_raises(Distribution::HistogramUnkownException) { @hist.mean }
	end

	def test_mean
		@hist.gen
		assert_equal @hist.mean.round(3),6.581
	end
end
