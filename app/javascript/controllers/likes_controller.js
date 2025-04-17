import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Connecting Controller...");
  }

  async toggle(event){
    event.preventDefault();
    
    const button = event.target;
    const form = button.closest("form");
    const url = form.action;
    const method = form.method;
    const formData = new FormData(form);

    try {
      const response = await fetch(url, {
        method: method.toUpperCase(),
        headers: {
          "Accept": "application/json"
        },
        body: formData
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        console.error("Backend error response:", errorData);
        throw new Error(`Fetch failed with status ${response.status}`);
      }

      const data = await response.json();

      if (data.action === "create") {
        button.classList.remove("btn-secondary-custom");
        button.classList.add("btn-main-custom");
      } else {
        button.classList.remove("btn-main-custom");
        button.classList.add("btn-secondary-custom");
      }

      const countText = this.pluralize("like", data.count);
      if (data.post_type === "Post") {
        let element = document.getElementById(`count-post-${data.post_id}`);

        if (data.count == 0){
          element.classList.add("d-none");
          return;
        }
        else{
          element.classList.remove("d-none");
          element.innerHTML = countText;
        }
      } else {
        let element = document.getElementById(`count-shared-post-${data.post_id}`)

        if (data.count == 0){
          element.classList.add("d-none");
          return;
        }
        else{
          element.classList.remove("d-none");
          element.innerHTML = countText;
        }
      }
    } catch (error) {
      console.error("Fetch error:", error);
    }
  }

  pluralize(word, count) {
    if (count === 0) return "";
    return count === 1 ? `<small><i>${count} ${word}</small></i>` : `<small><i>${count} ${word}` + "s<small></i>";
  }
}
