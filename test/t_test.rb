
require 'minitest/autorun'

require_relative '../lib/distribution'

class TestTlDsitribution < MiniTest::Unit::TestCase

	def setup
		@d = Distribution::T.new(x:[1,2,3,4],nu:2)
	end

  def test_results
      assert_equal @d.pdf, [0.192, 0.068, 0.027, 0.013]
      assert_equal @d.cdf, [0.789, 0.908, 0.952, 0.971]
      assert_equal @d.cdf(false), [0.211, 0.092, 0.048, 0.029]
  end  
end
