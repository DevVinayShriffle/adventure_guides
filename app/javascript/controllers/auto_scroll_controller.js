import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "container" ]

  connect() {
    this.startAutoScroll()
  }

  disconnect() {
    this.stopAutoScroll()
  }

  startAutoScroll() {
    this.scrollInterval = setInterval(() => {
      const container = this.containerTarget
      const scrollAmount = container.clientWidth
      
      // If at end, scroll back to start, otherwise scroll forward
      if (container.scrollLeft + container.clientWidth >= container.scrollWidth - 1) {
        container.scrollTo({ left: 0, behavior: 'smooth' })
      } else {
        container.scrollBy({ left: scrollAmount, behavior: 'smooth' })
      }
    }, 3000) // Scroll every 3 seconds
  }

  stopAutoScroll() {
    clearInterval(this.scrollInterval)
  }
}
