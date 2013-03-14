
module Distribution
	#implemented just pdf
	class Normal < BaseDistribution
		attr_reader :m, :o,:x
		alias_method :sigma, :o
		alias_method :mean, :m
		alias_method :raw_scores, :x

		def initialize(opts = {})
			@m = opts[:mean] || 0.0
 		   	@o = opts[:sigma] || 1.0
			@x = Vector.alloc( opts[:x] || [0] )
			@precision = opts[:precision] || 3
			super(opts)
		end

		def variance
			pow_int(@o,2)
		end
		
		def pdf
			@x.collect { |x| Ran::gaussian_pdf(x, @o).round(@precision) }
		end


		#lower_tail = true
		#P(X<=X)
		#lower_tail = false
		#P(X>=X)
		def cdf(lower_tail=true)
			method_to_call = if lower_tail
				:gaussian_P
			else
				:gaussian_Q
			end
			@x.collect { |x| Cdf.send(method_to_call,x, @o).round(@precision) }
		end

		def X(using=:mean)
			Vector.alloc(@samples.collect { |x| x.send(:mean) })
		end

		def standard_error
			self.X.sd
		end

		def hist(data_to_hist=self.X.round.to_a)
			super(data_to_hist)
		end

		
		def get_cases(n,c)
			Vector.alloc(1.upto(n*c).collect { @m + GSL::Ran::gaussian(random_handle, @o).round(@precision) })
		end
	end
end