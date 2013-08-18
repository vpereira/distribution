require 'minitest/unit'
require 'minitest/autorun'

require_relative '../lib/distribution'

class TestExponentialDistribution < MiniTest::Unit::TestCase
	def setup
		@d = Distribution::Exponential.new(mean:5,k:[2])
	end

	def test_1
		assert_equal @d.pdf.first, 0.134
		assert_equal @d.cdf.first, 0.33
		assert_equal @d.cdf(false).first.round(2), 0.67
	end

end
