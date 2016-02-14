# A demo app for the 500px API

This is a Rails app that demonstrates using the 500px API to display popular photos, use 500px for login, and liking of photos. You can [see it running on Heroku](https://fivehundredpx.herokuapp.com/).

This is a fairly straightforward app, with only a couple of [controllers](app/controllers) - one for photos, and one for handling users. We rely on 500px for our user data - "logging in" involves requesting account access from 500px, and if the user grants it to our app then we store it in our session. Similarly, logging out just removes the fields from the session. The oAuth process is managed by [OmniAuth](https://github.com/intridea/omniauth).

Access to the API is wrapped up in [a service object](app/services), which is a thin wrapper around [the f00px gem](https://github.com/500px/f00px). This makes it easy for us [to replace it with a mock object](spec/support/mock_services.rb) in our tests.

# Setup instructions

Presuming you have Ruby, git, and bundler installed already: 

1. Grab a copy of the application: `git clone https://github.com/creature/500px-demo.git`
2. Log in to 500px, then [register an app](https://500px.com/settings/applications).
3. Rename `.env.example` to `.env`, then edit `.env` to include your newly-registered app's consumer key and consumer secret.
4. `bundle install`
5. `bundle exec rails s`

# Miscellaneous notes

- Trying to use Emoji in an app description when registering an app on 500px results in an unhelpful error screen: 
![Screenshot of error](https://raw.githubusercontent.com/creature/500px-demo/master/public/screenshots/unhelpfulerror.jpg)
- The [f00px gem](https://github.com/500px/f00px) has some [useful methods](https://github.com/500px/f00px/blob/master/lib/f00px/request.rb) in it, but hasn't had an official release [for about 3 years](https://libraries.io/rubygems/f00px).
