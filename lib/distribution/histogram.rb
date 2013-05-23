require 'gnuplot'
# the class use gnuplot to calculate frequency and draw a histogram 
# limitations: the step is the same in this code. it can not be used to draw histogram with different steps.
module Distribution
  class Histogram
  	attr_reader :bins
  	attr_accessor :step 
    # array is the raw data, step is used when calculate frequency
    def initialize(values, step = 5)
      @min = (values.min - 0.5).round
      @fix_boxes_offset = step.to_f / 2.0
      @x = [@min + @fix_boxes_offset]
      max = values.max
      while @x[-1] <= (max - @fix_boxes_offset)
        @x << @x[-1] + step
      end
      @max = @x[-1] 
      @step = step
      #Y are the bins
      @bins = Array.new(h_class(@max)+1, 0)
      values.each{|i| push i}
    end
 
    def push(x)
      @bins[h_class([[@min,x].max, @max].min)]+=1
    end
	 
    def plot(opts = {})
      #fig_name="histogram", fig_dir=".", x_lab="", y_lab="", i_xtics=10, 
      #i_file="postscript eps color enhanced", i_size="0.5,0.5", i_style="fill solid 0.5 border")
	  opts = {:x_lab=>"",:y_lab=>"",:xtics=>10,:size=>"0.5,0.5",:style=>"fill solid 0.5 border"}.merge(opts)
      Gnuplot.open do |gp|
       Gnuplot::Plot.new( gp ) do |plot|
        #plot.term i_file
	 	#plot.output "#{fig_dir}/#{fig_name}"
	 	plot.autoscale
	 	plot.size opts[:size]
	 	plot.xrange "[#{@x[0] - @fix_boxes_offset - 1}:#{@x[-1] + @fix_boxes_offset + 1}]"
	 	plot.xtics opts[:xtics].to_s
	 	plot.yrange "[0:#{@bins.max * 1.1}]"
	 	plot.notitle
	 	plot.xlabel opts[:x_lab]
	 	plot.ylabel opts[:y_lab]
	 	plot.style  opts[:style]
	 	
	 	plot.data = [  
	      Gnuplot::DataSet.new([@x, @bins]) do |ds|
	        ds.with = "boxes"
	        ds.title = "step = #{@step}"
	      end 
	 	]
       end
      end
    end

    private

    #choose the bin where the number will be added
    def h_class(x)
      ((x-@min)/@step).truncate
    end

  end
end
