import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "startDate", "endDate", "submit" ]

  validate() {
    const startDate = new Date(this.startDateTarget.value)
    const endDate = new Date(this.endDateTarget.value)

    if (endDate < startDate) {
      this.endDateTarget.classList.add("is-invalid")
      this.submitTarget.disabled = true
    } else {
      this.endDateTarget.classList.remove("is-invalid")
      this.submitTarget.disabled = false
    }
  }
}
