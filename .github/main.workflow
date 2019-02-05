workflow "New workflow" {
  on = "push"
  resolves = ["GitHub Action for Heroku-1"]
}

action "GitHub Action for Heroku" {
  uses = "actions/heroku@9b6266f8ca2b26bc846af2547b2b11ad8a696223"
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "githubactionsember"
  }
}

action "login" {
  uses = "actions/heroku@master"
  args = "container:login"
  secrets = ["HEROKU_API_KEY"]
}

action "push" {
  uses = "actions/heroku@master"
  needs = "login"
  args = "container:push -a githubactionsember web"
  secrets = ["HEROKU_API_KEY"]
}
