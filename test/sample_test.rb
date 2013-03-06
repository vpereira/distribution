require 'minitest/autorun'

require_relative '../lib/distribution'

class TestSample < MiniTest::Unit::TestCase
    
    #test a loaded dice 
    def test_continuous
      s = Distribution::Sample.new cases:GSL::Vector.alloc([1,2,3,4,5,6,7,7,7,7,6,5,4,3,2,1]),type: :continuous
      assert_equal s.mean,  4.375
      assert_equal s.sigma, 2.187
    end

    def test_discrete
      s = Distribution::Sample.new cases:GSL::Vector.alloc([1,2,3,4,5,6,7,7,7,7,6,5,4,3,2,1]),type: :discrete
      assert_equal s.mean,  4.375
      assert_equal s.sigma, 2.187
    end
    def test_w_with_unknown_population
      s = Distribution::Sample.new cases:GSL::Vector.alloc([1,2,3,4,5,6,7,7,7,7,6,5,4,3,2,1]),type: :discrete
      assert_raises(Distribution::PopulationUnkownException) {s.t}
    end
end