require 'java'
require_relative '../common_maths/commons-math3-3.2.jar'
java_import 'org.apache.commons.math3.analysis.function.Sqrt'
java_import 'org.apache.commons.math3.random.EmpiricalDistribution'
module Distribution
	module Utils
		def sqrt(v)
			Sqrt.new.value(v)
		end
	end
	#common math doesn't support histogram. but it does support Frequency or Empirical Distribution
	#http://commons.apache.org/proper/commons-math/apidocs/org/apache/commons/math3/stat/Frequency.html
	#http://commons.apache.org/proper/commons-math/apidocs/org/apache/commons/math3/random/EmpiricalDistribution.html
	class Histogram
		attr_accessor :data
		attr_reader :hist
		#as parameter you should pass an array or GSL::Vector
		def initialize(opts = {})
			@data = opts[:data] || []
			@hist = EmpiricalDistribution.new  
		end
		def gen
			#temporary
			@hist.load(data.to_java(Java::double))
			@hist
		end
		def graph
			raise NotImplemented
		end
		def mean
			@hist.get_numerical_mean
		end
	end
end