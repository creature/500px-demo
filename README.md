# A demo app for the 500px API

This is a Rails app that demonstrates using the 500px API via [the f00px gem](https://github.com/500px/f00px).


# Setup instructions

Presuming you have Ruby, git, and bundler installed already: 

1. Grab a copy of the application: `git clone https://github.com/creature/fivehundredpx.git`
2. Log in to 500px, then [register an app](https://500px.com/settings/applications).
3. Rename `.env.example` to `.env`, then edit `.env` to include your newly-registered app's consumer key and consumer secret.
4. `bundle install`
5. `bundle exec rails s`


# Miscellanous notes

- Trying to use Emoji in an app description when registering an app on 500px results in an unhelpful error screen: 
![public/screenshots/unhelpfulerror.png]
