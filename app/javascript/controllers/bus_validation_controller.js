import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "error"]

  validate(event) {
    let hasError = false

    this.inputTargets.forEach((input) => {
      const field = input.dataset.field
      const errorElement = this.errorTargets.find(
        (el) => el.dataset.field === field
      )

      // Reset previous state
      input.classList.remove("border-red")
      errorElement.textContent = ""

      const value = input.value.trim()

      // NAME validation
      if (field === "name") {
        if (value === "") {
          hasError = true
          input.classList.add("border-red")
          errorElement.textContent = "Name can't be blank"
        } else if (value.length < 3) {
          hasError = true
          input.classList.add("border-red")
          errorElement.textContent = "Name must be at least 3 characters"
        }
      }

      // BUS TYPE validation
      if (field === "bus_type") {
        if (value === "") {
          hasError = true
          input.classList.add("border-red")
          errorElement.textContent = "Please select bus type"
        }
      }

      // CAPACITY validation
      if (field === "capacity") {
        if (value === "") {
          hasError = true
          input.classList.add("border-red")
          errorElement.textContent = "Capacity can't be blank"
        } else if (parseInt(value) <= 0) {
          hasError = true
          input.classList.add("border-red")
          errorElement.textContent = "Capacity must be greater than 0"
        }
      }

      // PRICE validation
      if (field === "price") {
        if (value === "") {
          hasError = true
          input.classList.add("border-red")
          errorElement.textContent = "Price can't be blank"
        } else if (parseFloat(value) < 0) {
          hasError = true
          input.classList.add("border-red")
          errorElement.textContent = "Price must be 0 or more"
        }
      }
    })

    if (hasError) {
      event.preventDefault()
    }
  }
}