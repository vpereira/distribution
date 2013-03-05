module Distribution
	class HistogramUnkownException < Exception;end
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
			raise HistogramUnkownException,"You didn't call gen before" if @hist.nil?
			@hist.graph
		end

		def mean
			raise HistogramUnkownException,"You didn't call gen before" if @hist.nil?
			@hist.mean
		end
	end
end