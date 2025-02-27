import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    transcription: { type: String, default: '' },
    assistantmessage: { type: String, default: '' },
    command: { type: String, default: '' },
    commandparams: { type: Object, default: {} },
  }

  connect() {
    if (this.commandValue == "find_image") {
      console.log("find an image");

      const newUrl = `${window.location.origin}${window.location.pathname}?query=${this.commandparamsValue.image_description}`;
      window.location.replace(newUrl);
    } else if (this.commandValue == "moveTo") {
      window.moveTo(this.commandparamsValue.x);
    } else if (this.commandValue == "come_to_us") {
      window.moveTo(0);
    } else if (this.commandValue == "jump") {
      window.animateModelJump();
    } else if (this.commandValue == "givePaw") {
      console.log("givePaw");
      window.animateModelGivePaw();
    } else if (this.commandValue == "sniff") {
      console.log("sniff");
      window.animateModelSniff();
    } else if (this.commandValue == "largerFont") {
      console.log("largerFont");

      const element = document.querySelector('#smallFontDiv');
      if (!element) {
        return;
      }

      if (element.classList.contains('text-xl')) {
        element.classList.remove('text-xl');
        element.classList.add('text-3xl');
      } else if (element.classList.contains('text-3xl')) {
        element.classList.remove('text-3xl');
        element.classList.add('text-5xl');
      }
    } else if (this.commandValue == "smallerFont") {
      console.log("smallerFont");

      const element = document.querySelector('#smallFontDiv');
      if (!element) {
        return;
      }

      if (element.classList.contains('text-3xl')) {
        element.classList.remove('text-3xl');
        element.classList.add('text-xl');
      } else if (element.classList.contains('text-5xl')) {
        element.classList.remove('text-5xl');
        element.classList.add('text-3xl');
      }
    } else if (this.commandValue == "darkMode") {
      console.log("darkMode");

      const element = document.querySelector('#darkModeDiv');
      if (!element) {
        return;
      }

      element.classList.remove('bg-white', 'text-black')
      element.classList.add('bg-black', 'text-white')

    } else if (this.commandValue == "find_laptop") {
      console.log("find a laptop");

      const form = document.notebook_filters;
      if (!form) {
        return;
      }

      let filtersAppiled = false;

      if (this.commandparamsValue.screen_diagonal && form.screen_diagonal) {
        form.screen_diagonal.value = this.commandparamsValue.screen_diagonal;

        filtersAppiled ||= true;
      }

      if (this.commandparamsValue.hard_drive_size && form.hard_drive_size) {
        form.hard_drive_size.value = this.commandparamsValue.hard_drive_size;

        filtersAppiled ||= true;
      }

      if (this.commandparamsValue.ram_size && form.ram_size) {
        form.ram_size.value = this.commandparamsValue.ram_size;

        filtersAppiled ||= true;
      }

      if (this.commandparamsValue.price_min && form.price_min) {
        form.price_min.value = this.commandparamsValue.price_min;

        filtersAppiled ||= true;
      }

      if (this.commandparamsValue.price_max && form.price_max) {
        form.price_max.value = this.commandparamsValue.price_max;

        filtersAppiled ||= true;
      }

      if (this.commandparamsValue.available_only && form.available_only) {
        form.available_only.checked = 'checked';

        filtersAppiled ||= true;
      }

      if (filtersAppiled) {
        const products = document.querySelectorAll('#products > div');

        let randomProductIndex;
        let randomProductElement;

        for (let i = 0; i < 4; i++){
          randomProductIndex = Math.floor((Math.random() * products.length));
          randomProductElement = products[randomProductIndex];

          randomProductElement.classList.add('hidden');
        }
      }

      const notebookFiltersComment = document.querySelector('#notebook_filters_comment');
      if (!notebookFiltersComment || !this.assistantmessageValue) {
        return;
      }

      notebookFiltersComment.classList.remove('hidden');
      const commentText = notebookFiltersComment.querySelector('#notebook_filters_comment_text');
      commentText.innerHTML = this.assistantmessageValue;
    }
  }
}
