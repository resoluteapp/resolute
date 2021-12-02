class SessionPolicy
	attr_reader :user, :session

	def initialize(user, session)
		@user = user
		@session = session
	end

	def destroy?
		session.user == user
	end
end
