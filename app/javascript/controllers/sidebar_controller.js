import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "toggleButton", "toggleIcon"]

  connect() {
    this.toggle = this.toggle.bind(this)
  }

  toggle() {
    this.sidebarTarget.classList.toggle("collapsed")
  }
}
