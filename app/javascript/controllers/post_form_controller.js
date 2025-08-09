import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "postType", "memoFields" ]

  connect() {
    this.toggleMemoFields()
  }

  toggleMemoFields() {
    if (this.postTypeTarget.value === "memo") {
      this.memoFieldsTarget.classList.remove("d-none")
    } else {
      this.memoFieldsTarget.classList.add("d-none")
    }
  }
}
