import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static values = {
		text: String,
	};
	static targets = ["button"];

	timeout: number | undefined;
	textValue: string;
	buttonTarget: HTMLElement;

	disconnect() {
		if (this.timeout !== undefined) {
			clearTimeout(this.timeout);
			this.timeout = undefined;
		}
	}

	copy() {
		navigator.clipboard.writeText(this.textValue);

		this.buttonTarget.innerText = "Copied!";

		if (this.timeout === null) {
			this.timeout = setTimeout(() => {
				this.buttonTarget.innerText = "Copy";
				this.timeout = undefined;
			}, 2000);
		}
	}
}
