import { Application } from "@hotwired/stimulus";

import AlertController from "./alert_controller";
import CopyController from "./copy_controller";
import FormConfirmController from "./form_confirm_controller";
import ResetFormController from "./reset_form_controller";

export default (application: Application) => {
	application.register("alert", AlertController);
	application.register("copy", CopyController);
	application.register("form-confirm", FormConfirmController);
	application.register("reset-form", ResetFormController);
};
