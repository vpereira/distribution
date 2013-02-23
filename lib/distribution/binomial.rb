module Distribution
	#just PMF is implemented
	#you can pass one k (number of successes) or an array
	class Binomial < BaseDistribution
		attr_reader :n,:p,:q,:k
		def initialize(n = 0, k = [0], p = 0.5)
			@n = n
			@p = p
			@q = 1 - @p
			@k = Vector.alloc(k)
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

		def skew
			@k.skew		
		end

		def median
			@k.sort.median_from_sorted_data
		end

		def quantile
		    @k.sort.quantile_from_sorted_data
		end

		def kurtosis
			@k.kurtosis
		end

		def to_report
			puts "trials:#{@n}"
			puts "random variable #{@k.join(',')}"
			puts "probability of successes: #{@p}"
			puts "mean: #{self.mean}"
			puts "standard deviation: #{self.sigma}"
			puts "skew: #{self.skew}"
			puts "kurtosis #{self.kurtosis}"
		end
	end
end
