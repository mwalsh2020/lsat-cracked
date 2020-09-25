import Choices from "choices.js"

const initCustomSelect = () => {
  const customSelectElements = document.querySelectorAll(".custom-select")
  customSelectElements.forEach((customSelectElement) => {
    const choices = new Choices(customSelectElement, {
      removeItemButton: true
    })
  })
}

export { initCustomSelect }
