// app/javascript/controllers/flash_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Automatically dismiss after 5 seconds
    setTimeout(() => {
      this.dismiss()
    }, 2000)
  }

  dismiss() {
    this.element.remove()
  }
}
