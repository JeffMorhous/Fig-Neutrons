# Lab 6 - Hiring Graders

### To install necessary gems, run

``bundle install``

### To serve the site locally, run
``rake db:setup`` which will set up the database and populate it with

``rails server`` which actually runs the site.


After running this command, open up localhost:3000 in a browser to display the information.

### To execute tests, run
``rails test``

### Features/Notes
- ADMIN ACCOUNT CREATION: run ```rails server``` and then ``` rails console ```. In the console, enter ```@admin = Admin.create(email: "admin1@admin.com", password: "admin123", password_confirmation: "admin123")```. 

### Styling

