import "@hotwired/turbo";
import { Application } from "@hotwired/stimulus";
import controllers from "controllers";

const application = Application.start();

declare global {
  interface Window {
    Stimulus: Application;
  }
}

window.Stimulus = application;

// Init Stimulus controllers
controllers(application);
