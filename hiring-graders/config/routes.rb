Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  # get 'images/osu_engineering_logo'

  # Register and Login Routes
  get 'user/signup'
  get 'user/login'
  get 'user/logout'
  post 'student/login'
  post 'instructor/login'
  post 'admin/login'

  # Instructor Routes
  get 'instructor/profile'
  get 'instructor/recommendation'
  get 'instructor/edit_recommendation'
  post 'instructor/create_recommendation', to: 'instructor#create_recommendation'
  get 'student/profile'
  get 'student/application'
  get 'student/application/edit'
  get 'admin/dashboard'


  #Admin Routes
  get 'admin/dashboard'

  # Student Routes
  get 'student/application'
  get 'student/profile'
  post 'student/create' # Routes to retrieve the student grader application
  post 'student/application' # Routes to save the grades
  post 'student/availability'

  # get 'student/application/edit'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
