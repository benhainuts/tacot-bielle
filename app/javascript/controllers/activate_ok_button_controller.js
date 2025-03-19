import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["checkbox", "button"]

  connect() {
    console.log("Hello from activate_ok_button_controller.js")
    this.activate()
  }

  activate(event) {
    event.preventDefault()
    const isAnyChecked = this.checkboxTargets.some(checkbox => checkbox.checked)
    this.buttonTarget.disabled = !isAnyChecked
    console.log(isAnyChecked)
  }
}
