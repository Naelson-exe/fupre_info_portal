import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.clickCount = 0
    this.clickTimer = null
    this.element.addEventListener("click", this.registerClick.bind(this))
    window.addEventListener("keydown", this.handleKeydown.bind(this))
  }

  disconnect() {
    this.element.removeEventListener("click", this.registerClick.bind(this))
    window.removeEventListener("keydown", this.handleKeydown.bind(this))
  }

  registerClick(event) {
    event.preventDefault()
    this.clickCount++
    if (this.clickCount === 3) {
      this.redirectToAdmin()
    }
    clearTimeout(this.clickTimer)
    this.clickTimer = setTimeout(() => {
      this.clickCount = 0
    }, 500)
  }

  handleKeydown(event) {
    if (event.ctrlKey && event.altKey && event.key === "a") {
      this.redirectToAdmin()
    }
  }

  redirectToAdmin() {
    window.location.href = "/admin"
  }
}
