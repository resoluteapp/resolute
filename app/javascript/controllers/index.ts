import { Application } from "@hotwired/stimulus";

import AlertController from "./alert_controller";
import CopyController from "./copy_controller";

export default (application: Application) => {
  application.register("alert", AlertController);
  application.register("copy", CopyController);
};
