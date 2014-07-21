FeedbacksController = Paloma.controller('Feedbacks')

FeedbacksController.prototype.create = ->
  redirectToReachPage = ->
    window.location = "/reach"
  setTimeout redirectToReachPage, 3000