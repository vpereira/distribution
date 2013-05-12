require 'java'
require_relative '../common_maths/commons-math3-3.2.jar'
java_import 'org.apache.commons.math3.distribution.BinomialDistribution'

module Distribution
	class Binomial
		attr_reader :n,:p,:q,:k,:rng
		def initialize(opts = {})
			opts = {:n=>1,:p=>0.5,:precision=>3,:k=>[0]}.merge(opts)
			@n = opts[:n]
			@p = opts[:p]
			@rng = opts[:rng]
			@precision = opts[:precision]
			@q = 1 - @p
			@k =  opts[:k]

			@d_handle = if opts[:rng]
				BinomialDistribution.new(opts[:n],opts[:p])
			else
				BinomialDistribution.new(opts[:rng],opts[:n],opts[:p])
			end
			@d_handle
		end

		def pmf
			@k.collect { |k|  @d_handle.probability(k).round(@precision)	} 
		end
		#TODO
		#refactor the if block: repetition
		def cdf(lower_tail = true)
			if lower_tail 
				@k.collect { |k|  @d_handle.cumulative_probability(k).round(@precision)	}
			else #P(X>x)
				@k.collect { |k|  1 - @d_handle.cumulative_probability(k).round(@precision)	}
			end
		end
		def mean
			@d_handle.get_numerical_mean.round(@precision)
		end
	end
end