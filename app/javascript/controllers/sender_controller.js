import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "source", "senderName", "senderTitle" ]

  connect() {
    this.updateSender()
  }

  updateSender() {
    const source = this.sourceTarget.value
    const senderOptions = JSON.parse(this.element.dataset.senderOptions)
    const sender = senderOptions[source]

    if (sender) {
      this.senderNameTarget.value = sender.name
      this.senderTitleTarget.value = sender.title
    }
  }
}
