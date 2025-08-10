// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import PostsLoaderController from "./posts_loader_controller.js"
application.register("posts-loader", PostsLoaderController)
