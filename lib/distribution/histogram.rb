module Distribution
	class Histogram
		attr_accessor :data
		attr_reader :hist
		#as parameter you should pass an array or GSL::Vector
		def initialize(opts = {})
			@data = opts[:data] || []
		end

		def gen
			@hist = GSL::Histogram.alloc(@data)
			@hist.set_ranges_uniform(@data.to_a.min-0.1,@data.to_a.max+0.1)
			@hist.fill(@data)
			@hist
		end

		def plot
			hist.graph
		end
	end
end