import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "submit" ]

  connect() {
    this.element.addEventListener("submit", this.disableSubmitButton.bind(this))
  }

  disconnect() {
    this.element.removeEventListener("submit", this.disableSubmitButton.bind(this))
  }

  disableSubmitButton() {
    this.submitTarget.disabled = true
    this.submitTarget.innerHTML = `
      <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
      Saving...
    `
  }
}
