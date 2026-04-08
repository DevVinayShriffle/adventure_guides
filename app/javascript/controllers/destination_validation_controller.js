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

      // Required validation
      if (value === "") {
        hasError = true
        input.classList.add("border-red")
        errorElement.textContent = `${field} can't be blank`
        return
      }

      // Name min length
      if (field === "name" && value.length < 3) {
        hasError = true
        input.classList.add("border-red")
        errorElement.textContent = "Name must be at least 3 characters"
      }

      // Location min length
      if (field === "location" && value.length < 3) {
        hasError = true
        input.classList.add("border-red")
        errorElement.textContent = "Location must be at least 3 characters"
      }
      
      //images
      // if (field === "images" && input.files.length === 0) {
      //   hasError = true
      //   input.classList.add("border-red")
      //   errorElement.textContent = "Please upload at least one image"
      // }
    })

    if (hasError) {
      event.preventDefault()
    }
  }
}