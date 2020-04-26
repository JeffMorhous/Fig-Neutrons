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
  get 'instructor/evaluation'

  get 'instructor/edit_recommendation' # show all recommendations made
  get 'instructor/evaluation_all' # show all evaluations made 
  get 'instructor/edit_evaluation/:id', to: 'instructor#evaluation_edit' #get the form for a specifc evaluation
  post 'instructor/update_evaluation/:id', to: 'instructor#update_evaluation' #update a specific evaluation

  get 'instructor/edit_recommendation/:id', to: 'instructor#edit' #edit a specific recommendation

  post 'instructor/create_evaluation' , to: 'instructor#create_evaluation'
  post 'instructor/create_recommendation', to: 'instructor#create_recommendation'
  post 'instructor/update_recommendation/:id', to: 'instructor#update_recommendation' #update a specific recommendation

  post 'instructor/create'

  #Admin Routes
  get 'admin/dashboard'
  post 'admin/section'
  post 'admin/select'
  post 'admin/delete'
  get 'admin/get_courses'

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
