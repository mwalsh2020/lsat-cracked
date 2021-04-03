class Charts::Skills
  def initialize

  end

  def tag_slugs
    @tag_slugs ||= Tag.pluck(:slug)
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
        data: Array.new(tags_count) { rand(7..10) * rand(7..10) },
        color: "rgb(200, 100, 100)"
      }]
    }
  end
end
