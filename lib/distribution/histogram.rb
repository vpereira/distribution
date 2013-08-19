#TODO
#as soon as we are ready with testing, remove it from here
require 'gnuplot'
# the class use gnuplot to calculate frequency and draw a histogram 
# limitations: the step is the same in this code. it can not be used to draw histogram with different steps.
#TODO 
#add support to save to file in different formats
#refactor the initialize method
module Distribution
  class HistogramUnkownException < StandardError;end
  class Histogram
  	attr_reader :bins
  	attr_accessor :step 
    # array is the raw data, step is used when calculate frequency
    def initialize(opts={})
      @data = opts[:data] || [0]
      @step = opts[:step] || 5
      @min = (@data.min - 0.5).round
      @fix_boxes_offset = @step / 2.0
      @x = [@min + @fix_boxes_offset]
   end
 
    def gen
      while @x[-1] <= (@data.max - @fix_boxes_offset)
        @x << @x[-1] + @step
      end
      @max = @x[-1] 
      @step = @step
      @bins = Array.new(h_class(@max)+1, 0)
      #push data to bins
      @data.each{|i| push i}
     end

    #TODO
    #implement mean
    def mean
      raise Distribution::HistogramUnkownException  unless @bins
      #slow we should build it around
      #http://commons.apache.org/proper/commons-math/apidocs/org/apache/commons/math3/stat/descriptive/DescriptiveStatistics.html
      @data.inject{ |sum, el| sum + el }.to_f / @data.size
    end

    def push(x)
      @bins[h_class([[@min,x].max, @max].min)]+=1
    end
	 
    def plot(opts = {})
      opts = {:x_lab=>"",:y_lab=>"",:xtics=>10,:size=>"0.5,0.5",:style=>"fill solid 0.5 border"}.merge(opts)
      Gnuplot.open do |gp|
       Gnuplot::Plot.new( gp ) do |plot|
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
