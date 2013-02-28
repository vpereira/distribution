module Distribution
	class Poisson < BaseDistribution
		attr_accessor :k
		attr_reader :mean

		def initialize(opts = {})
			@mean = opts[:mean]
			@k =  Vector.alloc( opts[:k] || [0] )
		end

		def pdf
			@k.collect { |k|  GSL::Ran.poisson_pdf(k,@mean.to_f) }
		end

		def cdf(lower_tail=true)
			method_to_call = if lower_tail
				:poisson_P
			else
				:poisson_Q
			end
			@k.collect { |k| Cdf.send(method_to_call,k, @mean.to_f) }
		end

		def sigma
			sqrt(@mean)
		end

		def kurtosis
			pow_int(@mean,-1)
		end

		def skewness
			pow_int(@mean,0.5)
		end

	end
end