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
			3 + 1/@mean.to_f
		end

		def skewness
			1/sqrt(@mean.to_f)
		end

	end
end