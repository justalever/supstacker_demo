import { Controller } from "@hotwired/stimulus"
import ClipboardJS from "clipboard"
import tippy from "tippy.js"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static values = {
    successMessage: { type: String, default: "Copied!" },
    errorMessage: { type: String, default: "Failed!" },
  }

  connect() {
    this.clipboard = new ClipboardJS(this.element)
    this.clipboard.on("success", () => this.tooltip(this.successMessageValue))
    this.clipboard.on("error", () => this.tooltip(this.errorMessageValue))
  }

  tooltip(message) {
    tippy(this.element, {
      content: message,
      showOnCreate: true,
      onHidden: (instance) => {
        instance.destroy()
      },
    })
  }
}
