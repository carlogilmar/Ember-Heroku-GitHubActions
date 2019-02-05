workflow "New workflow" {
  on = "push"
  resolves = ["Pushing to heroku"]
}

action "GitHub Action for Heroku" {
  uses = "actions/heroku@9b6266f8ca2b26bc846af2547b2b11ad8a696223"
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "githubactionsember"
  }
}

action "Adding to heroku repository" {
  uses = "actions/heroku@9b6266f8ca2b26bc846af2547b2b11ad8a696223"
  needs = ["GitHub Action for Heroku"]
  runs = "heroku git:remote -a githubactionsember"
  secrets = ["HEROKU_API_KEY"]
}

action "Pushing to heroku" {
  uses = "actions/heroku@9b6266f8ca2b26bc846af2547b2b11ad8a696223"
  needs = ["Adding to heroku repository"]
  runs = "git push heroku master"
  secrets = ["HEROKU_API_KEY"]
}
