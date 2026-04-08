import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String }

  redirectToUrl() {
    const destinationUrl = this.urlValue;
    if (destinationUrl) {
      // Use Turbo to navigate to the new URL without a full page reload
      Turbo.visit(destinationUrl);
    }
  }
}
