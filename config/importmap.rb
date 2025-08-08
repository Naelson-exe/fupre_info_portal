# Pin npm packages by running ./bin/importmap

pin "application"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "lodash", to: "https://ga.jspm.io/npm:lodash@4.17.21/lodash.js"
pin "jspdf", to: "https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"
pin "html2canvas", to: "https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"
