import { Application } from "@hotwired/stimulus";

const application = Application.start();

declare global {
  interface Window {
    Stimulus: Application;
  }
}

window.Stimulus = application;

export { application };
