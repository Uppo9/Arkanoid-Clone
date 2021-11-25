Paddle = BaseClass:Create()

function Paddle:Create(x, y, vX, vY, image)
	local o = BaseClass:Create(x, y, vX, vY, image)
	
	self.__index = self
        setmetatable(o, {index = BaseClass})
        setmetatable(o, self)
	return o
end

function Paddle:update(dt, ball)
	if love.keyboard.isDown('left') then
		self.x = self.x - self.vX * dt
	elseif love.keyboard.isDown('right') then
		self.x = self.x + self.vX * dt
	end
	if self.x < PADDLE_LEFT_BOUNDARY then
		self.x = self.x + self.vX * dt
	elseif self.x > PADDLE_RIGHT_BOUNDARY then
		self.x = self.x - self.vX * dt
	end
end
