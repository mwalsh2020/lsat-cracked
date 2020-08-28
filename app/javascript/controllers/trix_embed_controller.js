import Rails from "@rails/ujs"
import Trix from "trix"
window.trix = Trix

Trix.config.blockAttributes.heading2 = {
  tagName: "h2",
  terminal: true,
  breakOnReturn: true,
  group: false
}

class TrixEmbedController {
  constructor(element) {
    this.pattern = /^https:\/\/([^\.]+\.)?youtube\.com\/watch\?v=(.*)/

    this.element = element
    this.editor = element.editor
    this.toolbar = element.toolbarElement
    this.hrefElement = this.toolbar.querySelector("[data-trix-input][name='href']")
    this.embedContainerElement = this.toolbar.querySelector("[data-behavior='embed_container']")
    this.embedElement = this.toolbar.querySelector("[data-behavior='embed_url']")
    
    this.reset()
    this.installEventHandlers()
    this.addHeading2ButtonToToolbar()
  }

  addHeading2ButtonToToolbar() {
    const embedBtn = document.createElement("button");

    embedBtn.dataset.trixAttribute = "heading2"
    embedBtn.title = "Heading 2"
    embedBtn.innerHTML = "heading 2"
    embedBtn.type = "button"
    embedBtn.classList.add("trix-button", "trix-button--icon", "trix-button--icon-heading-2")
    event.target.toolbarElement.querySelector(".trix-button-group.trix-button-group--block-tools button").insertAdjacentElement("afterend", embedBtn)
  }

  installEventHandlers() {
    this.hrefElement.addEventListener("input", this.didInput.bind(this))
    this.hrefElement.addEventListener("focusin", this.didInput.bind(this))
    this.embedElement && this.embedElement.addEventListener("click", this.embed.bind(this))
  }

  didInput(event) {
    let value = event.target.value.trim()
    let matches = value.match(this.pattern)

    if (matches != null) {
      this.fetch(matches[2])

    } else {
      this.reset()
    }
  }

  fetch(value) {
    Rails.ajax({
      url: `/attachment/youtube_videos/${encodeURIComponent(value)}`,
      type: 'get',
      error: this.reset.bind(this),
      success: this.showEmbed.bind(this)
    })
  }

  embed(event) {
    if (this.currentEmbed == null) { return }

    let attachment = new Trix.Attachment(this.currentEmbed)
    this.editor.insertAttachment(attachment)
    this.element.focus()
  }

  showEmbed(embed) {
    this.currentEmbed = embed
    this.embedContainerElement && (this.embedContainerElement.style.display = "block")
  }

  reset() {
    this.embedContainerElement && (this.embedContainerElement.style.display = "none")
    this.currentEmbed = null
  }
}

export default TrixEmbedController
