import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["ingredients", "ingredientTemplate", "instructions", "instructionTemplate"]

  addIngredient() {
    this.addFromTemplate(this.ingredientTemplateTarget, this.ingredientsTarget)
  }

  addInstruction() {
    this.addFromTemplate(this.instructionTemplateTarget, this.instructionsTarget)
  }

  addFromTemplate(templateTarget, listTarget) {
    const content = templateTarget.innerHTML.replaceAll("NEW_RECORD", this.uniqueKey())
    listTarget.insertAdjacentHTML("beforeend", content)
  }

  uniqueKey() {
    return `${Date.now()}${Math.floor(Math.random() * 1000)}`
  }
}
