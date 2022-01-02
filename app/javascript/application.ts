import "@hotwired/turbo-rails";
import { Application } from "@hotwired/stimulus";
import controllers from "./controllers";

import Alpine from "alpinejs";
import persist from "@alpinejs/persist";

declare global {
	interface Window {
		Stimulus: Application;
	}
}

const application = Application.start();
window.Stimulus = application;

Alpine.plugin(persist);
Alpine.start();

// Init Stimulus controllers
controllers(application);
