import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="visibility-toggler"
export default class extends Controller {
  static targets = [ "togglableArea" ]

  toggleArea(e) {
    if(this.togglableAreaTarget.classList.contains("hidden")) {
      this.togglableAreaTarget.classList.remove("hidden");
      e.target.innerHTML = "remove_circle_outline"
    } else {
      this.togglableAreaTarget.classList.add("hidden");
      e.target.innerHTML = "add_circle_outline"
    }
  }
}
