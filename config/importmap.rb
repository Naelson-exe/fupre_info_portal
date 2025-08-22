# Pin npm packages by running ./bin/importmap

pin "application"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "lodash", to: "https://ga.jspm.io/npm:lodash@4.17.21/lodash.js"
pin "jspdf", to: "jspdf.umd.min.js"
pin "html2canvas", to: "html2canvas.min.js"
pin "bootstrap", to: "bootstrap.min.js"
pin "@popperjs/core", to: "popper.js"
pin "@babel/runtime/helpers/asyncToGenerator", to: "@babel--runtime--helpers--asyncToGenerator.js" # @7.28.3
pin "@babel/runtime/helpers/defineProperty", to: "@babel--runtime--helpers--defineProperty.js" # @7.28.3
pin "@babel/runtime/helpers/typeof", to: "@babel--runtime--helpers--typeof.js" # @7.28.3
pin "canvg" # @3.0.11
