import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  static targets = ["item"]
  static values = {
    items: Array
  }


  connect () {
    console.log("plan item selector connected, not used yet")
  }

}
