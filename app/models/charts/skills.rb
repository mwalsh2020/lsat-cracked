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
    360 / tags_count
  end

  def params
    {
      chart: {
        polar: true
      },
      title: {
        text: 'Highcharts Polar Chart'
      },
      subtitle: {
        text: 'Also known as Radar Chart'
      },
      pane: {
        startAngle: 0,
        endAngle: 360
      },
      xAxis: {
        tickInterval: 45,
        min: 0,
        max: 360,
        labels: {
          format: '{value}°'
        },
        categories: categories
      },
      yAxis: {
        min: 0
      },
      plotOptions: {
        series: {
          pointStart: 0,
          pointInterval: 45
        },
        column: {
          pointPadding: 0,
          groupPadding: 0
        }
      },
      series: [{
        type: 'area',
        data: [8, 7, 6, 5, 4, 3, 2, 1],
      }]
    }
  end
end
