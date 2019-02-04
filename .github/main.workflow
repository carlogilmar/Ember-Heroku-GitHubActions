workflow "New workflow" {
  on = "push"
  resolves = ["GitHub Action for Heroku"]
}

# Login
action "login" {
  uses = "actions/heroku@master"
  args = "container:login"
  secrets = ["HEROKU_API_KEY"]
}

action "GitHub Action for Heroku" {
  uses = "actions/heroku@9b6266f8ca2b26bc846af2547b2b11ad8a696223"
  args = ["container:push", "--app", "$HEROKU_APP", "web"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "githubactionsember"
  }
}
