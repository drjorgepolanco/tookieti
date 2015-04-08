#[CocinitApp](https://cocinitapp.herokuapp.com)
**Recipe sharing mobile web-app built with Ruby on Rails, HTML5, CoffeeScript and Sass.**

###Technologies
- Ruby on Rails 4.2
- HTML5
- Sass
- Zurb Foundation
- CoffeeScript

###Feautures
####(All written from scratch)
- Full Authentication System with:
	- Account Activation
	- Password Reset
- Users
	- Create
	- Read
	- Update
	- Destroy
	- Follow
	- Be followed  
- Recipes
	- Create, choosing Cuisines and Ingredients
	- Read
	- Update
	- Destroy
	- Like (Once per recipe per User)
- Cuisines
	- Create
	- Read 	
- Ingredients
	- Create
	- Read 
- Browse Recipes by: 
	- Ingredients
	- Cuisines
	- Users
	- All

##Production
- **Heroku:** Deployment
- **Puma:** Rack Server
- **SendGrid:** Mailer
- **Amazon S3:** Storage
- **SSL:** Security

###Testing
- RSpec
- Capybara
- FactoryGirl

Finished in 4.83 seconds (files took 7.22 seconds to load)

**102 examples, 0 failures**