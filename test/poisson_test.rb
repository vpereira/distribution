require 'minitest/unit'
require 'minitest/autorun'

require_relative '../lib/distribution'

class TestPoissonlDistribution < MiniTest::Unit::TestCase
	def test_1
		@d = Distribution::Poisson.new(mean:5,k:[2])
		assert_equal @d.skewness, 0.447
		assert_equal @d.kurtosis, 3.20
		assert_equal @d.pdf.first, 0.084
	end
end