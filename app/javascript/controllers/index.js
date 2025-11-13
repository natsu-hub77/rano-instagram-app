import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Import all controllers defined in the import map under controllers/*
// import controllers from "./**/*_controller.js"
// controllers.forEach((controller) => application.register(controller.name, controller.module))