class Charts::Tags
  attr_reader :tags_performances

  def initialize(tags_performances)
    @tags_performances = tags_performances
  end

  def tag_slugs
    tags_performances.map(&:slug)
  end

  def tags_count
    tag_slugs.count
  end

  def categories
    tag_slugs.map.with_index { |category, index| [interval * index, category] }.to_h
  end

  def interval
    360 / (tags_count + 1)
  end

  def full_angle
    interval * tags_count
  end

  def to_json
    params.to_json
  end

  def params
    {
      chart: {
        polar: true
      },
      legend: false,
      title: {
        text: "Skills Performance"
      },
      subtitle: {
        text: "Based on you last quizes"
      },
      xAxis: {
        tickInterval: interval,
        categories: categories,
        max: full_angle,
      },
      tooltip: {
        valueDecimals: 0,
        valueSuffix: "%",
      },
      yAxis: {
        max: 100,
        labels: {
          format: '{value}%'
        }
      },
      plotOptions: {
        series: {
          pointInterval: interval
        }
      },
      series: [{
        type: "area",
        name: "Performance",
        data: tags_performances.map { |performance| performance.value * 100 },
        color: "rgb(200, 100, 100)"
      }]
    }
  end
end
