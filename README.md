### Hexlet tests and linter status:
[![Actions Status](https://github.com/asagafonov/rails-project-65/workflows/hexlet-check/badge.svg)](https://github.com/asagafonov/rails-project-65/actions)

[![linter & tests](https://github.com/asagafonov/rails-project-65/actions/workflows/linter-and-tests.yml/badge.svg)](https://github.com/asagafonov/rails-project-65/actions/workflows/linter-and-tests.yml)

### [Deployment link](https://rails-bulletin-board.up.railway.app)

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

Add migration to make yourself admin (if you like)
```
class AddAdmins < ActiveRecord::Migration[7.0]
  def change
    User.find_by(email: 'your email here').update(admin: true)
  end
end

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

<hr>

### Coded by

[@asagafonov](https://github.com/asagafonov)