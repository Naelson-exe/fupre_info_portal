import { Controller } from "@hotwired/stimulus"
import validate from "validate.js"

export default class extends Controller {
  static targets = [ "form" ]

  connect() {
    this.formTarget.addEventListener("submit", this.validateForm.bind(this))
  }

  disconnect() {
    this.formTarget.removeEventListener("submit", this.validateForm.bind(this))
  }

  validateForm(event) {
    const form = event.target
    const constraints = {
      "post[title]": {
        presence: true,
      },
      "event[title]": {
        presence: true,
      },
      "event[event_date]": {
        presence: true,
      },
      "event[event_time]": {
        presence: true,
      },
    }

    const errors = validate(form, constraints)

    if (errors) {
      event.preventDefault()
      this.displayErrors(errors)
    }
  }

  displayErrors(errors) {
    for (const key in errors) {
      const input = this.formTarget.querySelector(`[name="${key}"]`)
      const errorContainer = document.createElement("div")
      errorContainer.classList.add("invalid-feedback")
      errorContainer.innerText = errors[key][0]

      input.classList.add("is-invalid")
      input.parentNode.appendChild(errorContainer)
    }
  }
}
