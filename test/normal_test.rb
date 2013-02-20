
require 'minitest/autorun'

require_relative '../lib/distribution'

class TestNormalDsitribution < MiniTest::Unit::TestCase
    
    #test a loaded dice 
    def test_results
      d = Distribution::Normal.new([1,2,3,4])
      assert_equal d.pdf,[0.24197072451914337, 0.05399096651318806, 0.0044318484119380075, 0.00013383022576488537]
    end
end

 