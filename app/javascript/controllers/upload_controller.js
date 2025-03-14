
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  selectFile() {
    this.inputTarget.click();
  }
}
