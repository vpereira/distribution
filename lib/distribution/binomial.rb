module Distribution
	class Binomial < BaseDistribution
		attr_reader :n,:p,:q,:k
		alias_method :raw_scores,:k
		def initialize(opts = {})
			@n = opts[:n] || 0
			@p = opts[:p] || 0.5
			@precision = opts[:precision] || 3
			@q = 1 - @p
			@k =  Vector.alloc( opts[:k] || [0] )
			super(opts)
		end

		# P(X=x)
		def pmf
			@k.collect { |k| (binomial_coefficient_from_array(k) * (pow_int(@p, k) * pow_int(@q,(@n-k)))).round(@precision)	} 
		end

		def pdf
			@k.collect { |k| Ran.binomial_pdf(k,@p,@n).round(@precision) }
		end

		def binomial_coefficient_from_array(k)
			(Sf::fact(@n) / (Sf::fact(k) * Sf::fact(@n - k))).round(@precision)
		end

		def hist(data_to_hist=@samples.first.cases)
			super(data_to_hist)
		end

		#lower_tail = true
		# P(X<=x)
		#lower_tail = false
		# P(X<=x)
		def cdf(lower_tail = true)

			method_to_call = if lower_tail
				:binomial_P
			else
				:binomial_Q
			end

			@k.collect { |k| Cdf.send(method_to_call,k,@p,@n).round(@precision) }
		end

		def mean
			@n * @p
		end

		#we should handle the difference for large/small samples
		def sigma
			 sqrt(@n * @q * @q)
		end

		def variance
			@n * @q * @p
		end

		def skewness
			((1 - 2 * @p) / sigma).round(@precision)
		end

		def kurtosis
			(3+(1-6 * @q * @p)/(@n * @q * @p)).round(@precision)
		end

		def symmetric?
			skewness == 0
		end

		def get_cases(n,c)
			Vector.alloc(1.upto(n * c).collect { GSL::Ran::binomial(random_handle,@p,@n) })
		end

		
		def to_report
			puts "trials:#{@n}"
			puts "random variable #{@k.join(',')}"
			puts "probability of successes: #{@p}"
			puts "mean: #{mean}"
			puts "standard deviation: #{sigma}"
			puts "skewness: #{skewness}"
			puts "kurtosis #{kurtosis}"
		end
	end
end
