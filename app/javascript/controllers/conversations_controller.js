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
    const token = document.querySelector('meta[name="csrf-token"]')?.content;
    if (!token || !this.hasMarkReadUrlValue) return;

    fetch(this.markReadUrlValue, {
      method: "PATCH",
      headers: { "X-CSRF-Token": token },
      credentials: "same-origin"
    });
  }
}
