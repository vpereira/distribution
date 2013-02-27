
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
			if lower_tail
				@x.collect { |x| Cdf::gaussian_P(x, @o) }
			else
				@x.collect { |x| Cdf::gaussian_Q(x, @o) }
			end
		end

		def get_samples(s,c,replacement=false,type=:discrete)
			r = GSL::Rng.alloc(GSL::Rng::MT19937,rand(10000))
			@samples = if replacement == true
				1.upto(s).collect { Distribution::Sample.new(cases: r.sample(get_cases(s,c),c), type: type) }
			else
				1.upto(s).collect { Distribution::Sample.new(cases: r.choose(get_cases(s,c),c), type: type ) }
			end
		end 

		def get_cases(n,c)
			rng = GSL::Rng.alloc
			cases = Vector.alloc(1.upto(n*c).collect { @m + GSL::Ran::gaussian(rng, @o).round(3) })
		end
	end
end