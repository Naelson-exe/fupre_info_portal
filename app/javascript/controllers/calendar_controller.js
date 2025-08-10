import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "listView", "calendarView" ]

  toggleView(event) {
    const view = event.currentTarget.dataset.view
    if (view === "list") {
      this.listViewTarget.classList.remove("d-none")
      this.calendarViewTarget.classList.add("d-none")
    } else {
      this.listViewTarget.classList.add("d-none")
      this.calendarViewTarget.classList.remove("d-none")
    }

    this.element.querySelectorAll(".btn-outline-primary").forEach((button) => {
      button.classList.remove("active")
    })
    event.currentTarget.classList.add("active")
  }

  switchCalendarView(event) {
    const view = event.currentTarget.dataset.view
    const calendarView = this.calendarViewTarget
    const url = new URL(window.location.href)

    if (view === "month") {
      url.searchParams.delete("start_date")
    } else {
      const today = new Date();
      const dateString = today.getFullYear() + '-' + String(today.getMonth() + 1).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0');
      url.searchParams.set("start_date", dateString)
    }

    fetch(url, {
      headers: {
        "X-Requested-With": "XMLHttpRequest"
      }
    })
    .then(response => response.text())
    .then(html => {
      const parser = new DOMParser();
      const doc = parser.parseFromString(html, "text/html");
      const newCalendar = doc.querySelector("#calendar-view").innerHTML;
      calendarView.innerHTML = newCalendar
    })

    this.element.querySelectorAll(".btn-outline-secondary").forEach((button) => {
      button.classList.remove("active")
    })
    event.currentTarget.classList.add("active")
  }
}
