import TrixEmbedController from "../controllers/trix_embed_controller"

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

const initTrix = () => {
  document.addEventListener("trix-initialize", (event) => {
    insertBtnSnippet(event.target);
    new TrixEmbedController(event.target);



    const embedBtn = document.createElement("button");
    embedBtn.innerHTML = "youtube";
    embedBtn.type = "button";
    embedBtn.classList.add("trix-button");
    embedBtn.classList.add("trix-button--icon");
    embedBtn.classList.add("trix-button--icon-heading-2");
    embedBtn.addEventListener("click", (event) => {
      const youtubeUrl = window.prompt("Please put a youtube link");
      const results = youtubeUrl.match(/.*youtube\.com\/watch\?v=(.*)/);
      if (!results){
        return;
      }
      const embedUrl = `https://www.youtube.com/embed/${results[1]}`;
  
      const attachment = new Trix.Attachment({content: `<iframe width="560" height="315" src="${embedUrl}" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>`});
      document.querySelector("trix-editor").editor.insertAttachment(attachment);
    });
    event.target.toolbarElement.querySelector(".trix-button-group.trix-button-group--block-tools button").insertAdjacentElement("afterend", embedBtn);
  })
}

export { initTrix }
