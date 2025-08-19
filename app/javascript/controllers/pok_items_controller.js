import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

// Connects to data-controller="pok-items"
export default class extends Controller {  
  populate_for_page(e) {
    const { value } = e.target
    get(`/sections/turbo_pok_items?page=${value}&format=turbo_stream`), {
      responseKind: "turbo-stream"
    }
  }
}
