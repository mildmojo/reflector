Reflector::Application.routes.draw do

  resources :rooms, except: [:new, :edit] do
    collection do
      post :join
    end
  end

  resources :channels, only: [] do
    resources :messages, except: [:edit, :update, :new] do
      collection do
        get 'since/:last_seen_id' => 'messages#since', as: :since
      end
    end
  end

end
