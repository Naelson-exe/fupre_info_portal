import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.addEventListener("keydown", this.handleKeyDown.bind(this))
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeyDown.bind(this))
  }

  handleKeyDown(event) {
    if (event.metaKey || event.ctrlKey) {
      switch (event.key) {
        case "n":
          this.navigateTo(event, "/admin/posts/new")
          break
        case "e":
          this.navigateTo(event, "/admin/events/new")
          break
        case "d":
          this.navigateTo(event, "/admin")
          break
      }
    }
  }

  navigateTo(event, path) {
    event.preventDefault()
    Turbo.visit(path)
  }
}
