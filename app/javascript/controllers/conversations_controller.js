import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { markReadUrl: String }

  connect() {
    this.updateConversation();

    this.observer = new MutationObserver(() => {
      this.updateConversation();
    });
    this.observer.observe(this.element, { childList: true, subtree: true });
  }

  disconnect() {
    if (this.observer) this.observer.disconnect();
  }

  updateConversation() {
    this.element.scrollTop = this.element.scrollHeight;
    this.markRead();
  }

  markRead() {
    fetch(this.markReadUrlValue, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      credentials: "same-origin"
    });
  }
}
