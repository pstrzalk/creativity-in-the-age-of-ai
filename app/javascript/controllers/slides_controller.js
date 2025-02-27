import { Controller } from "@hotwired/stimulus"

// uses hotkeys - https://stimulus.hotwired.dev/reference/actions#keyboardevent-filter

export default class extends Controller {
  connect() {}

  click() {
    this.element.click();
  }
}
