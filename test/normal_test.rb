
require 'minitest/autorun'

require_relative '../lib/distribution'

class TestNormalDsitribution < MiniTest::Unit::TestCase
    
    #test a loaded dice 
    def test_results
      d = Distribution::Normal.new([1,2,3,4])
      assert_equal d.pdf, GSL::Vector.alloc([0.24197072451914337, 0.05399096651318806, 0.0044318484119380075, 0.00013383022576488537])
      assert_equal d.cdf, GSL::Vector.alloc([0.8413447460685429, 0.9772498680518208, 0.9986501019683699, 0.9999683287581669])
      assert_equal d.get_10_samples.size,10
      assert_equal d.get_100_samples.size,100
    end
end

 