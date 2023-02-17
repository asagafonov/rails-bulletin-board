### Code quality status:

[![linter & tests](https://github.com/asagafonov/rails-project-65/actions/workflows/linter-and-tests.yml/badge.svg)](https://github.com/asagafonov/rails-project-65/actions/workflows/linter-and-tests.yml)

### [Deployment link](https://rails-bulletin-board.up.railway.app)

> Deployment might be down if Railway hours expire by the end of the month. Feel free to set up project locally, instructions below.

### Project description

Bulletin board app. Allows to create bulletins. Has admin space to control and moderate bulletin drafts. Has built-in search and pagination. Auth via GitHub.

<hr>

### Launch project locally

Set correct versions
```
16.19.0 for NodeJS
3.1.2 for Ruby
```

Install dependencies
```
bundle install
yarn install
```

Seed database
```
rails db:seed
```

Run migrations
```
rails migrate
```

Run server
```
rails server
```

Visit project locally
```
http://localhost:3000
```

Don't forget to make yourself admin for full experience

<hr>

### Coded by

[@asagafonov](https://github.com/asagafonov)