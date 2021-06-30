require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("trix")
require("@rails/actiontext")
require("jquery")
require("@nathanvda/cocoon")

import "controllers"
import bindTableLinks from '../components/table'
import bindDateTimePickers from '../components/date_time_picker'
import '../components/upload'

console.log('👋 Hello admin')

document.addEventListener("turbolinks:load", function () {
  bindDateTimePickers()
  bindTableLinks()
})

$(document).on('cocoon:after-insert', function (e, added_task) {
  bindDateTimePickers()
})
