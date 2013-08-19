require 'java'
require_relative '../common_maths/commons-math3-3.2.jar'
java_import 'org.apache.commons.math3.distribution.ExponentialDistribution'

module Distribution
	class Exponential
		attr_accessor :mean,:k,:precision

		def initialize(opts = {})
			@mean = opts[:mean] || 1
			@k =  opts[:k] || [0] 
			@precision = opts[:precision] || 3
			@d_handle = ExponentialDistribution.new(@mean) 
		end
		
		def pdf
			@k.collect { |k| @d_handle.density(k).round(@precision) }
		end

		# TODO
                # remove repetition
		def cdf(lower_tail=true)
			if lower_tail
				@k.collect { |k|      @d_handle.cumulative_probability(k).round(@precision) }
			else
				@k.collect { |k|  1 - @d_handle.cumulative_probability(k).round(@precision)	}
			end
		end

	end
end
