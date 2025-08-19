import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chunk-forms"
export default class extends Controller {
  static targets = [ "formSubtitle", "formCopy", "formFigure", "formVideo", "formPattern", 
    "figContent", "figNum", "figDesc" ]

  refreshFigContent() {
    let fig_num = this.figNumTarget.value
    let fig_desc = this.figDescTarget.value
    this.figContentTarget.value = [fig_num, fig_desc].join("|")
  }

  toggleForm(e) {
    if (e.target.id == "show-form-btn-subtitle") {
      this.toggleHidden(this.formSubtitleTarget)
    }
    if (e.target.id == "show-form-btn-copy") {
      this.toggleHidden(this.formCopyTarget)
    }
    if (e.target.id == "show-form-btn-figure") {
      this.toggleHidden(this.formFigureTarget)
    }
    if (e.target.id == "show-form-btn-video") {
      this.toggleHidden(this.formVideoTarget)
    }
    if (e.target.id == "show-form-btn-pattern") {
      this.toggleHidden(this.formPatternTarget)
    }
  }

  toggleHidden(target) {
      if (target.classList.contains("hidden")) {
        target.classList.remove("hidden")
      } else {
        target.classList.add("hidden")
      }
  }
}
