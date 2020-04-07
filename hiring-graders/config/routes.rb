Rails.application.routes.draw do
  get 'user/signup'
  get 'user/login'
  post 'student/login'
  post 'instructor/login'
  post 'admin/login'
  get 'instructor/recommendation'
  get 'student/application'
  post 'instructor/create'
  post 'student/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
