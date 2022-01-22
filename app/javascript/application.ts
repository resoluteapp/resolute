import "@hotwired/turbo-rails";
import { Application } from "@hotwired/stimulus";
import controllers from "./controllers";

import Alpine from "alpinejs";
import persist from "@alpinejs/persist";
import collapse from "@alpinejs/collapse";

declare global {
	interface Window {
		Stimulus: Application;
	}
}

const application = Application.start();
window.Stimulus = application;

Alpine.plugin(persist);
Alpine.plugin(collapse);
Alpine.start();

// Init Stimulus controllers
controllers(application);
