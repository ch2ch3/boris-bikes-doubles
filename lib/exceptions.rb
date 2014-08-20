module MyCustomErrors
	def initialize(message)
		super(message)
	end
end

class ContainerFullError < StandardError
	include MyCustomErrors
end

class ContainerEmptyError < StandardError
	include MyCustomErrors
end

class NotBikeError < StandardError
	include MyCustomErrors
end

class GreedyPersonError < StandardError
	include MyCustomErrors
end

class LateMateError < StandardError
	include MyCustomErrors
end