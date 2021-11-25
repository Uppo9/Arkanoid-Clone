StateMachine = {}

function StateMachine:Create(states)--Pstate can be a table
	o = {}
        setmetatable(o, self)
        self.__index = self

	o.currentState = nil 
	o.states = states
	return o
end

function StateMachine:change(state, variables)--changes the state if its a valid state
	self.currentState = state
	if variables ~= nil then
		self.states[state]:load(variables) --used to iniliaze values for entering the next state
	else
		self.states[state]:load()
	end
end

function StateMachine:update(dt)
	self.states[self.currentState]:update(dt)
end

function StateMachine:draw()
	self.states[self.currentState]:draw()
end
