import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-validation"
export default class extends Controller {
  static targets = ["input", "error"]
  static values = { availableSeats: Number }

  validate(event) {
    let hasError = false
    console.log(this.availableSeatsValue)

    this.inputTargets.forEach((input) => {
      const field = input.dataset.field
      const errorElement = this.errorTargets.find(
        (el) => el.dataset.field === field
      )

      // Reset previous state
      input.classList.remove("border-red")
      errorElement.textContent = ""

      const value = input.value.trim()

      if (field === "seats") {
        if (Number(value) > this.availableSeatsValue) {
          hasError = true
          input.classList.add("border-red")
          errorElement.textContent = "Not enough available seats."
        }
      }
    })

    if (hasError) {
      event.preventDefault()
    }
  }
}
