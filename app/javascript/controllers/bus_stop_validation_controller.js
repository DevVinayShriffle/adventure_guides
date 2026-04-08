import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "stopType",
    "pickupField",
    "dropField",
    "pickupInput",
    "dropSelect",
    "pickupError",
    "dropError",
    "typeError"
  ]

  connect() {
    this.toggleFields()
  }

  toggleFields() {
    const type = this.stopTypeTarget.value

    this.clearErrors()

    if (type === "pickup") {
      this.pickupFieldTarget.classList.remove("hidden")
      this.dropFieldTarget.classList.add("hidden")

      // Enable pickup input
      this.pickupInputTarget.disabled = false

      // Disable drop select
      this.dropSelectTarget.disabled = true
      this.dropSelectTarget.value = ""
    }

    if (type === "drop") {
      this.pickupFieldTarget.classList.add("hidden")
      this.dropFieldTarget.classList.remove("hidden")

      // Disable pickup input
      this.pickupInputTarget.disabled = true
      this.pickupInputTarget.value = ""

      // Enable drop select
      this.dropSelectTarget.disabled = false
    }
  }

  validateForm(event) {
    let valid = true
    const type = this.stopTypeTarget.value

    this.clearErrors()

    if (!type) {
      this.typeErrorTarget.textContent = "Please select stop type"
      valid = false
    }

    if (type === "pickup") {
      if (!this.pickupInputTarget.value.trim()) {
        this.pickupErrorTarget.textContent = "Pickup name is required"
        valid = false
      }
    }

    if (type === "drop") {
      if (!this.dropSelectTarget.value) {
        this.dropErrorTarget.textContent = "Please select a destination"
        valid = false
      }
    }

    if (!valid) {
      event.preventDefault()
    }
  }

  clearErrors() {
    this.pickupErrorTarget.textContent = ""
    this.dropErrorTarget.textContent = ""
    this.typeErrorTarget.textContent = ""
  }
}