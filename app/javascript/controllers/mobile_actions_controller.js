import { Controller } from "@hotwired/stimulus"

// Toggles the visibility of a dropdown menu and handles clicks outside.
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.boundClickHandler = this.clickOutside.bind(this)
    document.addEventListener("click", this.boundClickHandler)
  }

  disconnect() {
    document.removeEventListener("click", this.boundClickHandler)
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }

  clickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
    }
  }
}
