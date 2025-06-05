import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price-update"
export default class extends Controller {
  static targets = ["startDate", "endDate", "totalPrice"]
  static values = { rate: Number }

  connect() {
    console.log("Hello from controller")
  }

  update() {
    const startDate = new Date(this.startDateTarget.value);
    const endDate = new Date(this.endDateTarget.value)
    const today = new Date()
    console.log(today)
    console.log(startDate)
    if (endDate < startDate) {
        this.totalPriceTarget.innerText = "Dates invalid";
        alert("Please select valid dates");
    } else if (endDate >= startDate) {
        const totalPrice = (((endDate - startDate)/1000/60/60/24) + 1) * this.rateValue;
        this.totalPriceTarget.innerText = `Price: $${totalPrice}`;
    } else {
        this.totalPriceTarget.innerText = "Select dates";
    }
  }
}
