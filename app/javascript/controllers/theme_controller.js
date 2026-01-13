import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "label"]

  connect() {
    this.sync()
  }

  toggle() {
    const isDark = document.documentElement.classList.toggle("dark")
    localStorage.setItem("theme", isDark ? "dark" : "light")
    this.sync()
  }

  sync() {
    const isDark = document.documentElement.classList.contains("dark")

    if (this.hasButtonTarget) {
      this.buttonTarget.setAttribute("aria-pressed", String(isDark))
    }

    if (this.hasLabelTarget) {
      this.labelTarget.textContent = isDark ? "Light mode" : "Dark mode"
    }
  }
}
