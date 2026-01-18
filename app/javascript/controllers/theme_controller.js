import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["option"]

  connect() {
    this.mediaQuery = window.matchMedia("(prefers-color-scheme: dark)")
    this.mediaQueryListener = () => {
      if (this.currentPreference() === "system") {
        this.applyTheme("system")
      }
    }
    if (this.mediaQuery.addEventListener) {
      this.mediaQuery.addEventListener("change", this.mediaQueryListener)
    } else if (this.mediaQuery.addListener) {
      this.mediaQuery.addListener(this.mediaQueryListener)
    }
    this.sync()
  }

  disconnect() {
    if (!this.mediaQueryListener) return
    if (this.mediaQuery?.removeEventListener) {
      this.mediaQuery.removeEventListener("change", this.mediaQueryListener)
    } else if (this.mediaQuery?.removeListener) {
      this.mediaQuery.removeListener(this.mediaQueryListener)
    }
  }

  set(event) {
    const preference = event.currentTarget.dataset.themeValue
    localStorage.setItem("theme", preference)
    this.applyTheme(preference)
    const details = event.currentTarget.closest("details")
    if (details) details.removeAttribute("open")
    this.sync()
  }

  currentPreference() {
    return localStorage.getItem("theme") || "system"
  }

  applyTheme(preference) {
    const prefersDark = this.mediaQuery?.matches
    const shouldUseDark = preference === "dark" || (preference === "system" && prefersDark)
    document.documentElement.classList.toggle("dark", shouldUseDark)
  }

  sync() {
    const preference = this.currentPreference()
    this.applyTheme(preference)

    this.optionTargets.forEach((option) => {
      const isActive = option.dataset.themeValue === preference
      option.setAttribute("aria-pressed", String(isActive))
      option.setAttribute("aria-label", `${option.textContent} theme`)
    })
  }
}
