import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (this.element.classList.contains('alert-success')) {
      setTimeout(() => {
        this.dismiss()
      }, 5000)
    }
  }

  dismiss() {
    this.element.remove()
  }
}
