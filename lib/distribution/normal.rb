
module Distribution
	#implemented just pdf
	class Normal < BaseDistribution
		attr_reader :m, :o,:x, :samples
		alias_method :sigma, :o
		alias_method :mean, :m
		alias_method :raw_scores, :x

		def initialize(opts = {})
			@m = opts[:mean] || 0.0
 		   	@o = opts[:sigma] || 1.0
			@x = Vector.alloc( opts[:x] || [0] )
			@samples = Vector.alloc([0])
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

			method_to_call = if lower_tail
				:gaussian_P
			else
				:gaussian_Q
			end
			@x.collect { |x| Cdf.send(method_to_call,x, @o) }
		end

		def get_samples(s,c,replacement=false,type=:discrete)
			
			replacement_method = if replacement
				:sample
			else
				:choose
			end

			@samples = 1.upto(s).collect do 
				Distribution::Sample.new(cases: random_handle.send(replacement_method,get_cases(s,c),c), type: type) 
			end
			@samples
		end 

		def get_cases(n,c)
			cases = Vector.alloc(1.upto(n*c).collect { @m + GSL::Ran::gaussian(random_handle, @o).round(3) })
		end

		private
		def random_handle
			GSL::Rng.alloc(GSL::Rng::MT19937,rand(31337))
		end
	end
end