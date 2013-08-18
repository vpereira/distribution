require_relative './distribution'
java_import 'org.apache.commons.math3.distribution.BinomialDistribution'

module Distribution
	class Binomial
                include Distribution::Utils

		attr_reader :n,:p,:q,:k,:rng

		def initialize(opts = {})
			opts = {:n=>1,:p=>0.5,:precision=>3,:k=>[0]}.merge(opts)
			@n = opts[:n]
			@p = opts[:p]
			@rng = opts[:rng]
			@precision = opts[:precision]
			@q = 1 - @p
			@k =  opts[:k]

			@d_handle = if opts[:rng]
				BinomialDistribution.new(opts[:n],opts[:p])
			else
				BinomialDistribution.new(opts[:rng],opts[:n],opts[:p])
			end
			@d_handle
		end

		def pmf
			@k.collect { |k|  @d_handle.probability(k).round(@precision)	} 
		end

		def cdf(lower_tail = true)
                        method_to_call = if lower_tail
				:binomial_P
			else
				:binomial_Q
			end
			@k.collect { |k|  self.send(method_to_call,k).round(@precision)	}
		end


                def sigma
                        sqrt(@n * @q * @p)
                end

		def mean
			@d_handle.get_numerical_mean.round(@precision)
		end

                private

                def binomial_P(k)
                        @d_handle.cumulative_probability(k)
                end
                #P(X>x)
                def binomial_Q(k)
                        1 - binomial_P(k)
                end
	end
end
