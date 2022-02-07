Rails.application.routes.draw do
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	root to: 'landing#index'

	get 'signup', to: 'signup#index'
	post 'signup', to: 'signup#submit'
	get 'verify', to: 'signup#verify'
	post 'verify', to: 'signup#finalize'

	get 'forgot-password', to: 'auth#forgot_password'
	post 'forgot-password', to: 'auth#forgot_password_submit'
	get 'forgot-password/verify', to: 'auth#forgot_password_verify'
	post 'forgot-password/verify', to: 'auth#forgot_password_finalize'

	scope '/callback' do
		get 'github', to: 'oauth_callback#github'
		get 'twitter', to: 'oauth_callback#twitter'
	end

	get 'login', to: 'auth#login'
	post 'login', to: 'auth#auth'

	post 'logout', to: 'auth#logout'

	get 'home', to: 'reminders#index'
	resources :reminders, only: %i[create destroy]

	resources :integrations, only: %i[index]

	scope '/settings' do
		get '/', to: 'settings#index'
		post '/', to: 'settings#update'
		get 'security', to: 'settings#security'

		resources :sessions, path: 'security/sessions', only: %i[destroy] do
			collection do
				post 'destroy_all'
			end
		end

		resources :authorizations, path: 'security/authorizations', only: %i[destroy]
	end

	scope '/developer' do
		get '/', to: 'settings#developer'

		resources :oauth_apps, path: 'apps', path_names: { edit: 'settings' } do
			member do
				get 'advanced'
			end
		end

		resources :personal_tokens, path: 'tokens', only: %i[index new create destroy]
	end

	scope '/hovercard' do
		get 'unfurl', to: 'hovercard#unfurl'
	end

	match '/404', to: 'errors#not_found', via: :all
	match '/500', to: 'errors#internal_server_error', via: :all

	# load routes/api.rb
	draw :api
end
