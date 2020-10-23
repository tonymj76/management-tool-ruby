Rails.application.routes.draw do

  resources :projects do
    resources :tasks
  end
  # get '/:id', to: 'projects#show', as: 'project_view'
  resources :colaborators, only: [:create, :destroy]

  scope '/admin' do
    get '/users', to: 'users#index', as: 'users_index'
    resources :users
    get '/users/:id/projects', to: 'users#user_projects', as: 'user_projects'
    get '/users/:id/projects/:project_id', to: 'users#user_project_tasks', as: 'user_project_tasks'
    scope '/projects' do
      scope '/:project_id' do
        get '/mthreads/mthread_id', to: 'mthreads#edit', as: 'mthread_edit'
        post '/mthreads/mthread_id', to: 'mthreads#update', as: 'mthread_update'
        resources :mthreads, except: [:update] do
          resources :messages, only: [:create, :destroy]
          get '/messages/:message_id', to: 'messages#edit', as: 'message_edit'
          post '/messages/:message_id', to: 'messages#update', as: 'message_update'
        end
      end
      
      get 'all', to: 'users#project_all', as: 'admin_projects'
      get '/', to: 'users#project_new', as: 'admin_project_new'
      post '/', to: 'users#project_create', as: 'admin_project_create'
      get '/:id', to: 'users#project_show', as: 'admin_project'
      get '/:id/edit', to: 'users#project_edit', as: 'edit_admin_project'
      delete '/:id', to: 'users#project_destroy', as: 'delete_admin_project'
      patch '/:id', to: 'users#project_update', as: 'admin_project_update'
      scope '/:project_id/tasks' do
        post '/', to: 'users#task_create', as: 'new_admin_projects_task'
        get '/:id', to: 'users#task_edit', as: 'edit_admin_project_task'
        patch '/:id', to: 'users#task_update', as: 'update_admin_project_task'
        delete '/:id', to: 'users#task_destroy', as: 'delete_admin_project_task'
      end
    end
  end

  get '/register', to: 'users#new', as: 'new_user_registration'
  get    '/login',   to: 'sessions#new', as: 'new_user_session'
  post   '/login',   to: 'sessions#login', as: 'user_session'
  delete '/logout',  to: 'sessions#destroy', as: 'destroy_user_session'

  root to: "projects#index"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
