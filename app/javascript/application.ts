declare global {
	interface Window {
		Stimulus: Application;
		User: {
			user_id?: number;
			user_email?: string;
		};
	}

	// Variables provided by bin/esbuild
	const HONEYBADGER_API_KEY: string | undefined;
	const NODE_ENV: string | undefined;
	const GIT_REVISION: string | undefined;
}

import "@hotwired/turbo-rails";
import { Application } from "@hotwired/stimulus";
import controllers from "./controllers";

import Honeybadger from "@honeybadger-io/js/dist/browser/honeybadger";

Honeybadger.configure({
	apiKey: HONEYBADGER_API_KEY,
	environment: NODE_ENV ?? "development",
	revision: GIT_REVISION,
});

Honeybadger.setContext(window.User);

import Alpine from "alpinejs";
import persist from "@alpinejs/persist";
import collapse from "@alpinejs/collapse";

const application = Application.start();
window.Stimulus = application;

application.handleError = (error, message, detail) => {
	console.warn(message, detail);
	Honeybadger.notify(error);
};

Alpine.plugin(persist);
Alpine.plugin(collapse);
Alpine.start();

// Init Stimulus controllers
controllers(application);
