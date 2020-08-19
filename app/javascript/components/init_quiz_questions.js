const handleRemoveError = (event) => {
  const wrapper = event.currentTarget
  wrapper.classList.remove("is-invalid")
  wrapper.querySelector(".invalid-feedback").remove()
  wrapper.removeEventListener("click", handleRemoveError)
}

const initQuizQuestions = () => {
  document.querySelectorAll(".list-group.is-invalid").forEach((quizAnswer) => {
    quizAnswer.addEventListener("click", handleRemoveError)
  })
}

export { initQuizQuestions }
