module Distribution
	#just PMF is implemented
	#you can pass one k (number of successes) or an array
	class Binomial < BaseDistribution
		attr_reader :n,:p,:q,:k
		alias_method :raw_scores,:k
		def initialize(opts = {})
			@n = opts[:n] || 0
			@p = opts[:p] || 0.5
			@q = 1 - @p
			@k =  Vector.alloc( opts[:k] || [0] )
		end

		# P(X=x)
		def pmf
			@k.collect { |k| binomial_coefficient_from_array(k) * (pow_int(@p, k) * pow_int(@q,(@n-k)))	} 
		end

		def pdf
			@k.collect { |k| Ran.binomial_pdf(k,@p,@n) }
		end

		def binomial_coefficient_from_array(k)
			Sf::fact(@n) / (Sf::fact(k) * Sf::fact(@n - k))
		end

		#lower_tail = true
		# P(X<=x)
		#lower_tail = false
		# P(X<=x)
		def cdf(lower_tail = true)
			if lower_tail == true
				@k.collect { |k| Cdf.binomial_P(k,@p,@n) }
			else
				@k.collect { |k| Cdf.binomial_Q(k,@p,@n) }
			end
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
			(1 - 2 * @p) / sigma
		end

		def kurtosis
			3+(1-6 * @q * @p)/(@n * @q * @p)
		end

		def symmetric?
			skewness == 0
		end

		def get_samples(num_of_samples)
			1.upto(num_of_samples).collect { GSL::Ran::binomial(random_handle,@p,@n) }
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

		private
		def random_handle
			GSL::Rng.alloc(GSL::Rng::MT19937,rand(31337))
		end
	end
end
