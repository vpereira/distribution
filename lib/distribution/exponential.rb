module Distribution
	class Exponential < BaseDistribution
		def initialize(opts = {})
			@mean = opts[:mean]
			@k =  Vector.alloc( opts[:k] || [0] )
			@precision = opts[:precision] || 3
		end
		def pdf
			@k.collect { |k|  GSL::Ran.exponential_pdf(k,@mean.to_f).round(@precision) }
		end
		def cdf(lower_tail=true)
			method_to_call = if lower_tail
				:exponential_P
			else
				:exponential_Q
			end
			@k.collect { |k| Cdf.send(method_to_call,k, @mean.to_f).round(@precision) }
		end
	end
end