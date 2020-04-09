Rails.application.routes.draw do
  get 'user/signup'
  get 'user/login'
  get 'user/logout'
  post 'student/login'
  post 'instructor/login'
  post 'admin/login'
  get 'instructor/profile'
  get 'instructor/recommendation'
  get 'student/profile'
  get 'student/application'
  get 'student/application/edit'
  get 'admin/dashboard'
  post 'instructor/create'
  post 'student/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
