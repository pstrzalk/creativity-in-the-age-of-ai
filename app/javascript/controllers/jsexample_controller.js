import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const img = this.element.querySelector('img');

    img.addEventListener("click", (event) => {
      console.log(img);
      img.classList.add('animate-spin');

      setTimeout(() => {
        img.src = "/graphics/rcc-cracow.svg";
      }, 1000);

      setTimeout(() => {
        img.classList.remove('animate-spin');
      }, 2000);
    });
  }
}
