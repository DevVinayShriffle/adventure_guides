import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset"
export default class extends Controller {
  // connect() {
  // }
  static targets = ["current_password", 
    "current_password_error", 
    "new_password", 
    "new_password_error", 
    "confirm_password", 
    "confirm_password_error"]


  validate(event) {
    // let hasError = false
    const current_password = this.current_passwordTarget
    const new_password = this.new_passwordTarget
    const confirm_password = this.confirm_passwordTarget
    const current_password_error = this.current_password_errorTarget
    const new_password_error = this.new_password_errorTarget
    const confirm_password_error = this.confirm_password_errorTarget

    //reset all field
    new_password.classList.remove("border-red-500")
    new_password_error.textContent = ""
    confirm_password.classList.remove("border-red-500")
    confirm_password_error.textContent = ""
    current_password.classList.remove("border-red-500")
    current_password_error.textContent = ""

    //current_password blank check
    if (current_password.value.trim() === ""){
      return
    }

    //current_password present
    if (current_password.value.trim() !== ""){
      if(new_password.value.trim() === ""){
        event.preventDefault()
        new_password.classList.add("border-red-500")
        new_password_error.textContent = `new password can't be blank`
        return
      }

      if(confirm_password.value.trim() === ""){
        event.preventDefault()
        console.log("confirm_password not present")
        confirm_password.classList.add("border-red-500")
        confirm_password_error.textContent = `confirm password can't be blank`
        return
      }

      if (new_password.value !== confirm_password.value){
        event.preventDefault()
        console.log("new and confirm password not matched")
        confirm_password.classList.add("border-red-500")
        confirm_password_error.textContent = "new and confirm password not matched"
        return
      }

      if(new_password.value === current_password.value){
        event.preventDefault()
        console.log("new and current password are equal ")
        new_password.classList.add("border-red-500")
        new_password_error.textContent = "new and current password are equal "
        return
      }
    }
  }
}
