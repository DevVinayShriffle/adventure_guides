import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "departure",
    "arrival",
    "bus",
    "busError",
    "departureError",
    "arrivalError"
  ]

  validateForm(event) {
    let valid = true

    this.clearErrors()

    const departureValue = this.departureTarget.value
    const arrivalValue = this.arrivalTarget.value
    const busValue = this.busTarget.value

    // Presence validation
    if (!departureValue) {
      this.showError(this.departureTarget, this.departureErrorTarget, "Departure is required")
      valid = false
    }

    if (!arrivalValue) {
      this.showError(this.arrivalTarget, this.arrivalErrorTarget, "Arrival is required")
      valid = false
    }

    if (!busValue) {
      this.showError(this.busTarget, this.busErrorTarget, "Bus is required")
      valid = false
    }

    // Comparison validation
    if (departureValue && arrivalValue) {
      const departureDate = new Date(departureValue)
      const arrivalDate = new Date(arrivalValue)

      if (departureDate >= arrivalDate) {
        this.showError(
          this.departureTarget,
          this.departureErrorTarget,
          "Departure must be before arrival"
        )
        valid = false
      }
    }

    if (!valid) {
      event.preventDefault()
    }
  }

  showError(input, errorElement, message) {
    input.classList.add("border-red")
    errorElement.textContent = message
  }

  clearErrors() {
    this.departureTarget.classList.remove("border-red")
    this.arrivalTarget.classList.remove("border-red")
    this.busTarget.classList.remove("border-red")

    this.departureErrorTarget.textContent = ""
    this.arrivalErrorTarget.textContent = ""
    this.busErrorTarget.textContent = ""
  }
}