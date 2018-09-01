Rails.application.routes.draw do
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  defaults format: :json do
    namespace :auth do
      post 'sign_up', to: 'registrations#create'
      delete 'destroy', to: 'registrations#destroy'
      post 'sign_in', to: 'sessions#create'
      delete 'sign_out', to: 'sessions#destroy'
    end

    resources :lists do
      resources :items do
        member do
          put :change_status
        end
      end
    end
  end
end
