// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import * as Turbo from "@hotwired/turbo";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

import "../controllers";

import "@fontsource/outfit/300.css";
import "@fontsource/outfit/600.css";
import "@fortawesome/fontawesome-free/css/all.css";

Rails.start();
ActiveStorage.start();

Turbo.setProgressBarDelay(0);
