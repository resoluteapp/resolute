import { Context, Controller } from "@hotwired/stimulus";
import { computePosition, flip, offset } from "@floating-ui/dom";

const cache: Record<string, string | null> = {};

export default class extends Controller {
	card: HTMLElement | undefined;

	delayController: DelayController;

	// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
	private url = this.element.getAttribute("href")!;

	constructor(ctx: Context) {
		super(ctx);

		this.delayController = new DelayController(
			200,
			100,
			async (on, content) => {
				if (on) {
					if (content !== null && content !== undefined) {
						await this.show(content);
					}
				} else {
					this.hide();
				}
			},
			async () => {
				let content: string | null;

				if (cache[this.url] !== undefined) {
					content = cache[this.url];
				} else {
					content = await this.getUnfurlContent(this.url);
					cache[this.url] = content;
				}

				return content;
			}
		);
	}

	hover() {
		this.delayController.on();
	}

	remove() {
		this.delayController.off();
	}

	private async show(content: string) {
		if (this.card !== undefined) return;

		const card = document.createElement("div");
		card.style.position = "absolute";
		card.style.zIndex = "50";

		card.innerHTML = content;

		card.addEventListener("mouseenter", () => {
			this.delayController.on();
		});

		card.addEventListener("mouseleave", () => {
			this.delayController.off();
		});

		document.body.appendChild(card);

		const { x, y } = await computePosition(this.element, card, {
			placement: "top-start",
			middleware: [offset(10), flip()],
		});

		card.style.left = `${x}px`;
		card.style.top = `${y}px`;

		this.card = card;
	}

	private async hide() {
		this.card?.remove();
		this.card = undefined;
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

/**
 * DelayController is a two-state controller ("on" and "off") that has a delay while switching between the two states.
 */
class DelayController<T = unknown> {
	state: "on" | "transitioning-to-on" | "transitioning-to-off" | "off" = "off";
	onTimeout: number | undefined;
	offTimeout: number | undefined;

	listener: (on: boolean, data?: T) => unknown;
	dataFetcher: (() => Promise<T>) | undefined;

	onDelay: number;
	offDelay: number;

	constructor(
		onDelay: number,
		offDelay: number,
		listener: (on: boolean, data?: T) => Promise<unknown>,
		dataFetcher?: () => Promise<T>
	) {
		this.onDelay = onDelay;
		this.offDelay = offDelay;

		this.listener = listener;
		this.dataFetcher = dataFetcher;
	}

	on() {
		switch (this.state) {
			case "transitioning-to-off":
				clearTimeout(this.offTimeout);
				this.state = "on";
				break;
			case "off":
				this.onTimeout = window.setTimeout(async () => {
					this.state = "on";
					this.onTimeout = undefined;

					if (this.dataFetcher) {
						const data = await this.dataFetcher();

						if (this.state === "on") {
							this.listener(true, data);
						}
					} else {
						this.listener(true);
					}
				}, this.onDelay);
				this.state = "transitioning-to-on";
				break;
		}
	}

	off() {
		switch (this.state) {
			case "transitioning-to-on":
				clearTimeout(this.onTimeout);
				this.state = "off";
				break;
			case "on":
				this.offTimeout = window.setTimeout(() => {
					this.state = "off";
					this.listener(false);
					this.offTimeout = undefined;
				}, this.offDelay);
				this.state = "transitioning-to-off";
				break;
		}
	}
}
