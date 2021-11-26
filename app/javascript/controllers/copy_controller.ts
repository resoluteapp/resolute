import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    text: String,
  };

  copy() {
    navigator.clipboard.writeText(this.textValue);
  }
}
