// External libraris
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("@rails/actiontext")
require("bootstrap")

import { initTrix } from "../component/init_trix"

initTrix()
