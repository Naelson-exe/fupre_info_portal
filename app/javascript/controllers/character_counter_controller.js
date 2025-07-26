import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
    this.update()
  }

  update() {
    const characterCount = this.element.value.length
    this.outputTarget.textContent = `${characterCount} characters`
  }
}
