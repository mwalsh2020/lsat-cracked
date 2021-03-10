import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form"]

  showQuiz() {
    location = "#intro-quiz"
    event.currentTarget.classList.add("d-none")
    this.formTarget.classList.remove("d-none")
  }
}
