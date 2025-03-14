import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "destination"]

  connect() {
    this.update();
  }

  update() {
    this.destinationTarget.value = this.sourceTarget.value;
  }
}
