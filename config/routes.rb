Rails.application.routes.draw do
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	root to: 'landing#index'

	get 'signup', to: 'signup#index'
	post 'signup', to: 'signup#submit'
	get 'verify', to: 'signup#verify'
	post 'verify', to: 'signup#finalize'

	get 'forgot-password', to: 'auth#forgot_password'

	scope '/callback' do
		get 'github', to: 'oauth_callback#github'
		get 'twitter', to: 'oauth_callback#twitter'
	end

	get 'login', to: 'auth#login'
	post 'login', to: 'auth#auth'

	get 'logout', to: 'auth#logout'

	get 'home', to: 'reminders#index'
	resources :reminders, except: [:show]

	get 'settings', to: 'settings#index'

	scope '/developer' do
		get '/', to: 'settings#developer'

		resources :oauth_apps, path: 'apps' do
			member do
				get 'advanced'
			end
		end
	end

	# load routes/api.rb
	draw :api
end
