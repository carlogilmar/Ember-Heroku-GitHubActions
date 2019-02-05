workflow "Deploy in Heroku" {
  on = "push"
  resolves = ["GitHub Action for Heroku", "Run Heroku CLI in Docker"]
}

action "Run Heroku CLI in Docker" {
  uses = "actions/heroku@9b6266f8ca2b26bc846af2547b2b11ad8a696223"
  secrets = ["HEROKU_API_KEY", "GITHUB_TOKEN"]
}

action "Add Heroku repo" {
  uses = "actions/heroku@9b6266f8ca2b26bc846af2547b2b11ad8a696223"
  needs = ["Run Heroku CLI in Docker"]
  secrets = ["HEROKU_API_KEY"]
  runs = "heroku git:remote -a githubactionsember"
}

action "GitHub Action for Heroku" {
  uses = "actions/heroku@9b6266f8ca2b26bc846af2547b2b11ad8a696223"
  needs = ["Add Heroku repo"]
  secrets = ["HEROKU_API_KEY"]
  runs = "container:push -a githubactionsember"
}
