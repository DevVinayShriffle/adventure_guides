import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["dropdown"]

  connect() {
    // Ensure the connect method binds the correct context of 'this'
    this.close = this.close.bind(this);
    document.addEventListener("click", this.close);
  }

  disconnect() {
    // Best practice to remove event listener when the controller is disconnected
    document.removeEventListener("click", this.close);
  }

  toggle(event) {
    event.stopPropagation();
    // Toggle the 'hidden' class
    this.dropdownTarget.classList.toggle("hidden");
  }

  close(event) {
    // Only close if the click is outside the controller's element and the dropdown is visible
    if (!this.element.contains(event.target) && !this.dropdownTarget.classList.contains("hidden")) {
      this.dropdownTarget.classList.add("hidden");
    }
  }
}
