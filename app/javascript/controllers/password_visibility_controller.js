import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["passwordInput", "toggleIcon"];

  connect() {
    this.toggleIconTarget.classList.add("fa-eye-slash");
  }

  toggle() {
    const input = this.passwordInputTarget;
    const icon = this.toggleIconTarget;
    
    // Toggle the type attribute between 'password' and 'text'
    if (input.getAttribute("type") === "password") {
      input.setAttribute("type", "text");
      icon.classList.remove("ri-eye-line");
      icon.classList.add("ri-eye-off-line");
    } else {
      input.setAttribute("type", "password");
      icon.classList.remove("ri-eye-off-line");
      icon.classList.add("ri-eye-line");
    }
  }
}
