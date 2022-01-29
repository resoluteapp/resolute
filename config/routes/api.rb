namespace :api do
	scope '/oauth' do
		get 'authorize', to: 'oauth#authorize'
		post 'authorize', to: 'oauth#authorize_submit'
		post 'token', to: 'oauth#token'
	end

	defaults format: :json do
		get 'me', to: 'users#me'
		resources :reminders, only: %i[index create destroy]
	end
end
