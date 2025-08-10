import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.loadPosts()
  }

  loadPosts() {
    const url = new URL(window.location.href);
    url.searchParams.set('format', 'json');

    fetch(url)
      .then(response => response.text())
      .then(html => {
        this.element.innerHTML = html
      })
  }
}
