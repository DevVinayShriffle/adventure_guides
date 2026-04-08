import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "error"]

  validate(event) {
    let hasError = false

    this.inputTargets.forEach((input) => {
      const fieldName = input.dataset.field
      const errorTarget = this.errorTargets.find(
        (el) => el.dataset.field === fieldName
      )

      // Reset state
      input.classList.remove("border-red-500")
      errorTarget.textContent = ""

      if (input.value.trim() === "") {
        hasError = true
        input.classList.add("border-red-500")
        errorTarget.textContent = `${fieldName} can't be blank`
      }

      // Email validation
      if (fieldName === "email" && input.value.trim() !== "") {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
        if (!emailRegex.test(input.value)) {
          hasError = true
          input.classList.add("border-red-500")
          errorTarget.textContent = "Invalid email format"
        }
      }

      // Password min length
      if (fieldName === "password" && input.value.trim() !== "") {
        if (input.value.length < 6) {
          hasError = true
          input.classList.add("border-red-500")
          errorTarget.textContent = "Password must be at least 6 characters"
        }
      }
    })

    if (hasError) {
      event.preventDefault()
    }
  }
}