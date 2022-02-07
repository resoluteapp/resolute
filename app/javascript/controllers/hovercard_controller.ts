import { Controller } from "@hotwired/stimulus";
import { computePosition, flip, offset } from "@floating-ui/dom";

const cache: Record<string, string | null> = {};

export default class extends Controller {
	card: HTMLElement | null = null;
	hovered = false;

	async hover() {
		this.hovered = true;

		// Don't do anything if the current card is still visible
		if (this.card !== null) return;

		const url = this.element.attributes.getNamedItem("href").value;

		let content: string;

		if (cache[url]) {
			content = cache[url];
		} else if (cache[url] === null) {
			return;
		} else {
			content = await this.getUnfurlContent(url);
			cache[url] = content;

			if (content === null) {
				return;
			}
		}

		if (this.hovered && this.card === null) {
			const card = document.createElement("div");
			card.style.position = "absolute";
			card.style.zIndex = "50";

			card.innerHTML = content;

			document.body.appendChild(card);

			const { x, y } = await computePosition(this.element, card, {
				placement: "top-start",
				middleware: [offset(10), flip()],
			});

			card.style.left = `${x}px`;
			card.style.top = `${y}px`;

			this.card = card;
		}
	}

	remove() {
		this.hovered = false;

		if (this.card !== null) {
			this.card.remove();
			this.card = null;
		}
	}

	private async getUnfurlContent(url: string): Promise<string | null> {
		const query = new URLSearchParams({ url });

		const response = await fetch(`/hovercard/unfurl?${query}`);

		if (response.status === 200) {
			return await response.text();
		} else {
			return null;
		}
	}
}
