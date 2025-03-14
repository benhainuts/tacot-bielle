// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

import AutoFillController from "./controllers/auto_fill_controller.js"
Stimulus.register("auto-fill", AutoFillController)
