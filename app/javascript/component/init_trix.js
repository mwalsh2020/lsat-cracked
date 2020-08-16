import Trix from "trix"
import Rails from "@rails/ujs"

const addAttachmentBehaviorToLinkButton = () => {
  let lang = Trix.config.lang;
  Trix.config.toolbar = {
    getDefaultHTML: function() {
      return `
      <div class="trix-button-row">
        <span class="trix-button-group trix-button-group--text-tools" data-trix-button-group="text-tools">
          <button type="button" class="trix-button trix-button--icon trix-button--icon-bold" data-trix-attribute="bold" data-trix-key="b" title="${lang.bold}" tabindex="-1">${lang.bold}</button>
          <button type="button" class="trix-button trix-button--icon trix-button--icon-italic" data-trix-attribute="italic" data-trix-key="i" title="${lang.italic}" tabindex="-1">${lang.italic}</button>
          <button type="button" class="trix-button trix-button--icon trix-button--icon-strike" data-trix-attribute="strike" title="${lang.strike}" tabindex="-1">${lang.strike}</button>
          <button type="button" class="trix-button trix-button--icon trix-button--icon-link" data-trix-attribute="href" data-trix-action="link" data-trix-key="k" title="${lang.link}" tabindex="-1">${lang.link}</button>
        </span>
        <span class="trix-button-group trix-button-group--block-tools" data-trix-button-group="block-tools">
          <button type="button" class="trix-button trix-button--icon trix-button--icon-heading-1" data-trix-attribute="heading1" title="${lang.heading1}" tabindex="-1">${lang.heading1}</button>
          <button type="button" class="trix-button trix-button--icon trix-button--icon-quote" data-trix-attribute="quote" title="${lang.quote}" tabindex="-1">${lang.quote}</button>
          <button type="button" class="trix-button trix-button--icon trix-button--icon-code" data-trix-attribute="code" title="${lang.code}" tabindex="-1">${lang.code}</button>
          <button type="button" class="trix-button trix-button--icon trix-button--icon-bullet-list" data-trix-attribute="bullet" title="${lang.bullets}" tabindex="-1">${lang.bullets}</button>
          <button type="button" class="trix-button trix-button--icon trix-button--icon-number-list" data-trix-attribute="number" title="${lang.numbers}" tabindex="-1">${lang.numbers}</button>
          <button type="button" class="trix-button trix-button--icon trix-button--icon-decrease-nesting-level" data-trix-action="decreaseNestingLevel" title="${lang.outdent}" tabindex="-1">${lang.outdent}</button>
          <button type="button" class="trix-button trix-button--icon trix-button--icon-increase-nesting-level" data-trix-action="increaseNestingLevel" title="${lang.indent}" tabindex="-1">${lang.indent}</button>
        </span>
        <span class="trix-button-group trix-button-group--file-tools" data-trix-button-group="file-tools">
          <button type="button" class="trix-button trix-button--icon trix-button--icon-attach" data-trix-action="attachFiles" title="${lang.attachFiles}" tabindex="-1">${lang.attachFiles}</button>
        </span>
        <span class="trix-button-group-spacer"></span>
        <span class="trix-button-group trix-button-group--history-tools" data-trix-button-group="history-tools">
          <button type="button" class="trix-button trix-button--icon trix-button--icon-undo" data-trix-action="undo" data-trix-key="z" title="${lang.undo}" tabindex="-1">${lang.undo}</button>
          <button type="button" class="trix-button trix-button--icon trix-button--icon-redo" data-trix-action="redo" data-trix-key="shift+z" title="${lang.redo}" tabindex="-1">${lang.redo}</button>
        </span>
      </div>
  
      <div class="trix-dialogs" data-trix-dialogs>
        <div class="trix-dialog trix-dialog--link" data-trix-dialog="href" data-trix-dialog-attribute="href">
          <div class="trix-dialog__link-fields">
            <input type="url" name="href" class="trix-input trix-input--dialog" placeholder="${lang.urlPlaceholder}" aria-label="${lang.url}" required data-trix-input>
            <div class="trix-button-group">
              <input type="button" class="trix-button trix-button--dialog" value="${lang.link}" data-trix-method="setAttribute">
              <input type="button" class="trix-button trix-button--dialog" value="${lang.unlink}" data-trix-method="removeAttribute">
            </div>
          </div>
          <div data-behavior="embed_container">
            <div class="d-flex align-items-center mt-2 link_to_embed link_to_embed--new">
              Would you like to embed media from this site?
              <input type="button" class="btn-sm border border-dark rounded btn-muted ml-1" data-behavior="embed_url" value="OK, embed it!">
            </div>
          </div>
        </div>
      </div>
    `
    }
  }
}

const embedBtnSnippet = (element) => {
  return `
  <div data-behavior="embed_container">
    <div class="d-flex align-items-center mt-2 link_to_embed link_to_embed--new">
      Would you like to embed media from this site?
      <input type="button" class="btn-sm border border-dark rounded btn-muted ml-1" data-behavior="embed_url" value="OK, embed it!">
    </div>
  </div>
  `;
}

const insertBtnSnippet = (editor) => {
  const embedContainer = editor.toolbarElement.querySelector("[data-behavior='embed_container']");

  if (embedContainer === undefined || embedContainer === null){
    editor.toolbarElement.querySelector(".trix-dialogs .trix-dialog--link").insertAdjacentHTML("beforeend", embedBtnSnippet());
  }
}

class EmbedController {
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
  }

  installEventHandlers() {
    this.hrefElement.addEventListener("input", this.didInput.bind(this))
    this.hrefElement.addEventListener("focusin", this.didInput.bind(this))
    this.embedElement.addEventListener("click", this.embed.bind(this))
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
    this.embedContainerElement.style.display = "block"
  }

  reset() {
    this.embedContainerElement.style.display = "none"
    this.currentEmbed = null
  }
}

const initTrix = () => {
  addAttachmentBehaviorToLinkButton();
  document.addEventListener("trix-initialize", (event) => {
    insertBtnSnippet(event.target);
    new EmbedController(event.target);
  })
}

export { initTrix }
