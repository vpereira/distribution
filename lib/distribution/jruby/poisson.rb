require_relative './distribution'
java_import 'org.apache.commons.math3.distribution.PoissonDistribution'

module Distribution
	class Poisson
		attr_accessor :k
		attr_reader :mean
		
		include Distribution::Utils

		def initialize(opts = {})
			@mean = opts[:mean] || 1
			@k =  opts[:k] || [0]
			@precision = opts[:precision] || 3
			@d_handle = PoissonDistribution.new(@mean)
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
		def sigma
			sqrt(@mean)
		end

		def kurtosis
			(3 + 1/@mean.to_f).round(@precision)
		end

		def skewness
			(1/sqrt(@mean.to_f)).round(@precision)
		end
	end
end