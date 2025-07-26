import { Controller } from "@hotwired/stimulus"
import { debounce } from "lodash"

export default class extends Controller {
  initialize() {
    this.save = debounce(this.save, 5000).bind(this)
  }

  save() {
    const form = this.element
    const formData = new FormData(form)
    formData.set("post[status]", "draft")

    fetch(form.action, {
      method: form.method,
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === "success") {
        // Optionally, provide feedback to the user that the draft has been saved.
        console.log("Draft saved successfully")
      }
    })
  }
}
