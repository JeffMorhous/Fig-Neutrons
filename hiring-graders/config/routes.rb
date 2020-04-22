Rails.application.routes.draw do
  # Landing page
  get 'welcome/index'
  root 'welcome#index'

  # Register and Login Routes
  get 'user/signup' # View for sign up page
  get 'user/login' # View for login page
  get 'user/logout' 
  post 'student/login' # Handle login for student and redirect to student profile
  post 'instructor/login' # Handle login for instructor and redirect to instructor profile
  post 'admin/login'

  # Instructor Routes
  get 'instructor/profile'
  get 'instructor/recommendation'
  get 'instructor/edit_recommendation'
  get 'instructor/edit_recommendation/:id', to: 'instructor#edit'

  post 'instructor/create_recommendation', to: 'instructor#create_recommendation'
  post 'instructor/update_recommendation/:id', to: 'instructor#update_recommendation'

  post 'instructor/create'

  #Admin Routes
  get 'admin/dashboard'
  post 'admin/section'
  post 'admin/select'

  # Student Routes
  get 'student/application' # Routes to retrieve the student grader application
  get 'student/application/edit'
  get 'student/profile'
  post 'student/create' 
  post 'student/application' # Routes to save the grades
  post 'student/availability'

  # get 'student/application/edit'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
