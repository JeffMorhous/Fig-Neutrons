# Lab 6 - Hiring Graders
This web application is designed for the OSU CSE department to streamline the process for hiring graders for CSE courses. Students and instructors are allowed to sign up and apply to be a grader or submit recommendations, and allows the CSE department to select qualified applicants.

## Installation/Running the Application

### To install necessary gems, run

``bundle install``

### To serve the site locally, run
``rake db:setup`` which will set up the database and populate it with the CSE courses offered

``rails server`` which actually runs the site.


After running this command, open up localhost:3000 in a browser to display the application.

### To execute tests, run
``rails test``

## Critical Features
- Student Application
  - Enter CSE course grades
  - Collect interested courses
  - Fill out availability
  - Edit grades/availability
- Instructor Recommendation
  -  Adding endorsements for students
  - Requesting a specific student grader
- Admin Dashboard
  - Display courses that require grader
  - View instructor recommendations
  - Select from student applicants


## Notes
- _**Creating an account for an admin is not open to the end-user as it is for the CSE department only. To create an account for an admin and access admin functionality, run:**_

  ```rails server```

  Then, in a separate terminal run:

  ``` rails console ``` 

  and then  
  
  ``` @admin = Admin.create(email: "admin@admin.com", password: "admin123", password_confirmation: "admin123") ``` 
  - A new admin account with email: admin@admin.com and password: admin123 is created and can be used when logging in.
- To collect the student's availability a third party jquery plugin was used which can be found be [here](https://github.com/shonihei/weekly-scheduler-component)
- To display the student's availability on the profile, a ruby gem, [Simple Calendar](https://excid3.github.io/simple_calendar/) was used.
- Other design decisions can be found in the presentation below

## Styling
- Utilized bootstrap heavily for layout and styling

## Final Project Presentation
- View the final presentation here: 

