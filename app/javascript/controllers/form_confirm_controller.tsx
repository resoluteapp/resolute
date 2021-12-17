import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static values = {
		title: String,
		text: String,
		actionText: { type: String, default: "Delete" },
	};

	titleValue: string;
	textValue: string;
	actionTextValue: string;

	modal: Element | null;
	submitting: boolean;

	initialize() {
		this.modal = null;
		this.submitting = false;
	}

	submit(e: SubmitEvent) {
		if (!this.submitting) {
			e.preventDefault();

			this.showModal();
		} else {
			this.submitting = false;
		}
	}

	private hideModal() {
		if (this.modal !== null) {
			this.modal.addEventListener("transitionend", () => {
				this.modal.remove();
				this.modal = null;
			});
			this.modal.classList.add("opacity-0");
		}
	}

	private showModal() {
		if (this.modal !== null) return;

		const modal: Element = (
			<div
				class="bg-black/50 fixed top-0 left-0 w-screen h-screen z-50 flex items-center justify-center opacity-0 transition-opacity"
				onClick={(e: Event) => {
					if (e.target === e.currentTarget) {
						this.hideModal();
					}
				}}
			>
				<div class="bg-gray-800 rounded-md p-7 w-96">
					<div class="mb-5 flex justify-between items-center">
						<div class="text-xl">{this.titleValue}</div>
					</div>

					<div class="mb-5">{this.textValue}</div>

					<div class="flex gap-3 justify-end">
						<button class="btn bg-gray-700" onClick={() => this.hideModal()}>
							Cancel
						</button>
						<button
							class="btn bg-red-500"
							onClick={() => {
								this.submitting = true;
								(this.element as HTMLFormElement).requestSubmit();
							}}
						>
							{this.actionTextValue}
						</button>
					</div>
				</div>
			</div>
		);

		document.body.appendChild(modal);

		setTimeout(() => modal.classList.remove("opacity-0"), 10);

		this.modal = modal;
	}
}
