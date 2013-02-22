module Distribution
	#just PMF is implemented
	#you can pass one k (number of successes) or an array
	class Binomial < BaseDistribution
		attr_reader :n,:p,:q,:k
		def initialize(n = 0, k = [0], p = 0.5)
			@n = n
			@p = p
			@q = 1 - @p
			@k = k.is_a?(Array) ? k : [k]
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

		# P(X<=x)
		def cdf(x)
			@k.collect { |k| Cdf.binomial_P(k,@p,@n) }
		end

		def mean
			@n * @p
		end

	end
end
