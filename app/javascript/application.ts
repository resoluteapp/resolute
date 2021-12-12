import "@hotwired/turbo";
import Alpine from "alpinejs";
import { Application } from "@hotwired/stimulus";
import controllers from "./controllers";

const application = Application.start();

declare global {
	interface Window {
		Stimulus: Application;
	}
}

window.Stimulus = application;

Alpine.start();

// Init Stimulus controllers
controllers(application);
