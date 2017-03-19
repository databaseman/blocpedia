
Title:  blocpedia /Wikiiki

Description:  a Wikiiki replica to teach the fundamentals of web development and Rails. 

Technology:  HTML, CSS, Ruby on Rails, Devise, Stripe, Pundit

Install on Cloud9:
  Go to your Cloud9 dashboard  
  Create new workspace
    Workspace name:  blocpedia 
    Choose Ruby template
    Clone from Git URL: https://github.com/databaseman/blocpedia.git

Run on Cloud9:
  Setup Sendgrid email server
      Run the following commands in cmd.exe
      $ heroku auth:logout
      $ heroku addons:create sendgrid:starter

  Start web server by running the following command:
     rails server -b $IP -p $PORT
  Wait for web server to start
  Go to URL: https://blocpedia-<c9username>.c9users.io 


Install on Heroku (all works are done from Cloud9):
  $ git add -A
  $ git commit -m "Setup for Heroku"
  $ git push
  $ heroku create
  $ git push heroku master
  $ heroku run rake db:migrate
  $ heroku run rake db:seed   (optional)
  Go to web site returned from push command.  For example
     https://secure-springs-93236.herokuapp.com/index.html

  You can rename the url by doing the following:
    $ heroku apps:rename minh-blocit
    Go to new URL: https://minh-blocit.herokuapp.com

Git remote heroku updated
 ?    Don't forget to update git remotes for all other local checkouts of the app.

Testing
  Visa:  4242424242424242
