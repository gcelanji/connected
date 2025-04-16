import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "count" ]

  connect() {
  }

  toggle(event){
    event.preventDefault();
    
    const button = event.target
    const form = button.closest("form")
    const url = form.action
    const method = form.method
    const formData = new FormData(form)

    const response = fetch(url, {
      method: method.toUpperCase(),
      headers: {
        "Accept": "application/json"
      },
      body: formData
    })
    .then(response => {
      if (!response.ok) throw response
      return response.json()
    })
    .then(data => {
      if (data.action == "create"){
        button.classList.remove("btn-secondary-custom")
        button.classList.add("btn-main-custom")
      }
      else {
        button.classList.remove("btn-main-custom")
        button.classList.add("btn-secondary-custom")
      }

      this.countTarget.innerHTML = this.pluralize("like", data.count)
    })
    .catch(async (error) => {
      const errorData = await error.json()
      console.error("Error:", errorData)
    })
  }

  pluralize(word, count) {
    if (count === 0) return ""
    return count === 1 ? `<small><i>${count} ${word}</small></i>` : `<small><i>${count} ${word}` + "s<small></i>"
  }
}
