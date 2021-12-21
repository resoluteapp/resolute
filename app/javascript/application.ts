import "@hotwired/turbo-rails";
import Alpine from "alpinejs";
import { Application } from "@hotwired/stimulus";
import controllers from "./controllers";

declare global {
	interface Window {
		Stimulus: Application;
	}
}

const application = Application.start();
window.Stimulus = application;

Alpine.start();

// Init Stimulus controllers
controllers(application);
