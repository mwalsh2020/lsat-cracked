import { Controller } from "stimulus"
import {Highcharts} from 'highcharts-more-node'

export default class extends Controller {
  connect() {
    const categories = [
      "Bar0",
      "Bar45",
      "Bar90",
      "Bar135",
      "Bar180",
      "Bar225",
      "Bar270",
      "Bar315",
    ]
    Highcharts.chart(this.element, JSON.parse(this.element.dataset.params))
  }
}
