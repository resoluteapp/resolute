import { Controller } from "@hotwired/stimulus";

export default class extends Controller<HTMLFormElement> {
	reset() {
		this.element.reset();
	}
}
