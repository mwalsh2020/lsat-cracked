import { Controller } from "stimulus"
import {Highcharts} from 'highcharts-more-node'

export default class extends Controller {
  connect() {
    Highcharts.chart(this.element, JSON.parse(this.element.dataset.params))
  }
}
