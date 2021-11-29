namespace :api do
	scope '/oauth' do
		get 'authorize', to: 'oauth#authorize'
		post 'authorize', to: 'oauth#authorize_submit'
		post 'token', to: 'oauth#token'
	end

	get 'me', to: 'users#me'
	resources :reminders, only: [:index]
end
