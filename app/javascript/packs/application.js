// External libraris
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("@rails/actiontext")
require("bootstrap")

import { initNavbar } from "../components/init_navbar"
import { initTrix } from "../components/init_trix"
import { initQuizQuestions } from "../components/init_quiz_questions"
import { initCustomSelect } from "../components/init_custom_select"

initTrix()

document.addEventListener("turbolinks:load", (event) => {
  initNavbar()
  initQuizQuestions();
  initCustomSelect();
})
