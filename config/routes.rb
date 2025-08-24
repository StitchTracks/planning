Rails.application.routes.draw do
  get "chunks/edit"
  resources :tracks do
    collection do
      patch :move_to
    end
    member do
      get :pok_items
      patch :assign_to_chapter
      patch :section_absorb_orphan_PoKs
      patch :move_chapter
      patch :move_to
    end
  end
  resources :chapters do
    member do
      patch :move_section
      get :preview
    end
  end
  resources :sections do
    collection do
      get :turbo_pok_items
    end
    member do
      patch :add_subtitle_chunk
      patch :add_copy_chunk
      patch :add_figure_chunk
      patch :add_video_chunk
      patch :add_pattern_chunk
      patch :add_aside_chunk
      patch :move_chunk
      patch :move_chunk_to
      patch :remove_chunk
      patch :associate_subject_item
      patch :associate_pok_item
      patch :unassociate_subject_item
      patch :unassociate_pok_item
      patch :move_pok_item_to
      patch :absorb_orphan_PoKs
      post :set_input_mode
    end
  end
  resources :chunks, only: [ :edit, :update ]
  resources :subject_items
  resources :pok_items do
    collection do
      get :orphans
      get :chapters
    end
    member do
      get :chapter
      get :section
      get :subsection
      patch :assign_to_chapter
      patch :unassign
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
