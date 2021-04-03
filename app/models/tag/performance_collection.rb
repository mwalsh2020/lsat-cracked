class Tag::PerformanceCollection
  include Enumerable

  attr_reader :performances
  def initialize(tag_performances_attributes)
    @performances = tag_performances_attributes.map {|attrs|
      Tag::Performance.new(attrs)
    }
  end

  def each(&block)
    @performances.each(&block)
  end

  def chart
    Charts::Tags.new(performances)
  end
end
