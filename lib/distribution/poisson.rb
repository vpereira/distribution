module Distribution
	class Poisson < BaseDistribution
		attr_accessor :k
		attr_reader :mean

		def initialize(opts = {})
			@mean = opts[:mean]
			@k =  Vector.alloc( opts[:k] || [0] )
			@precision = opts[:precision] || 3
		end

		def pdf
			@k.collect { |k|  GSL::Ran.poisson_pdf(k,@mean.to_f).round(@precision) }
		end

		def cdf(lower_tail=true)
			method_to_call = if lower_tail
				:poisson_P
			else
				:poisson_Q
			end
			@k.collect { |k| Cdf.send(method_to_call,k, @mean.to_f).round(@precision) }
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

		def get_cases(n,c)
			Vector.alloc(1.upto(n * c).collect { GSL::Ran::poisson(random_handle,@mean) })
		end
	end
end