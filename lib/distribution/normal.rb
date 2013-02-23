module Distribution
	#implemented just pdf
	class Normal < BaseDistribution
		attr_reader :m, :o
		def initialize(x = [0], mean = 0.0, stddev = 1.0)
			@m = mean
			@o = stddev
			@x = Vector.alloc(x)
		end
		def variance
			pow_int(@o,2)
		end
		def pdf
			@x.collect { |x| Ran::gaussian_pdf(x, @o) }
		end

		#lower_tail = true
		#P(X<=X)
		#lower_tail = false
		#P(X>=X)
		def cdf(lower_tail=true)
			if lower_tail
				@x.collect { |x| Cdf::gaussian_P(x, @o) }
			else
				@x.collect { |x| Cdf::gaussian_Q(x, @o) }
			end
		end
	end
end
