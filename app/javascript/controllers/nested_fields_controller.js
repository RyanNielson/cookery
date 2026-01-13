import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["ingredients", "ingredientTemplate", "instructions", "instructionTemplate"]

  connect() {
    this.renumberInstructions()
  }

  addIngredient() {
    this.addFromTemplate(this.ingredientTemplateTarget, this.ingredientsTarget)
    this.focusLastField(this.ingredientsTarget)
  }

  addInstruction() {
    this.addFromTemplate(this.instructionTemplateTarget, this.instructionsTarget)
    this.renumberInstructions()
    this.focusLastField(this.instructionsTarget)
  }

  addFromTemplate(templateTarget, listTarget) {
    const content = templateTarget.innerHTML.replaceAll("NEW_RECORD", this.uniqueKey())
    listTarget.insertAdjacentHTML("beforeend", content)
  }

  uniqueKey() {
    return `${Date.now()}${Math.floor(Math.random() * 1000)}`
  }

  focusLastField(listTarget) {
    const lastItem = listTarget.lastElementChild
    if (!lastItem) return

    const field = lastItem.querySelector("input:not([type='hidden']), textarea, select")
    if (field) field.focus()
  }

  renumberInstructions() {
    if (!this.hasInstructionsTarget) return
    const items = this.instructionsTarget.querySelectorAll("[data-instruction-item]")

    items.forEach((item, index) => {
      const stepLabel = item.querySelector("[data-step-label]")
      const positionInput = item.querySelector("input[name$='[position]']")
      if (stepLabel) stepLabel.textContent = `${index + 1}`
      if (positionInput) positionInput.value = index + 1
    })
  }
}
