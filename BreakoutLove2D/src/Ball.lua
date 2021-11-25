Ball = BaseClass:Create()

function Ball:Create(x, y, vX, vY, image)
	local o = BaseClass:Create(x, y, vX, vY, image)
	o.vX = 0
	o.vY = 0
	o.bounceOffBrick = true
	o.currentSpeed = BALLSPEED
	local angle = 0
	while angle == 0 or angle > 50 and angle > -50 do
		angle = math.random(-180, 180)
	end
	o.vX = math.sin(angle) * o.currentSpeed
	o.vY = math.cos(angle) * o.currentSpeed
	self.__index = self
	setmetatable(o, {index = BaseClass})
        setmetatable(o, self)
	return o
end

function Ball:wallReact(dt)
	if self.x < 0 then
		self.x = self.x - self.vX * dt
		self.vX = -self.vX
		local sound = love.audio.newSource('sound/Brick_Hit.wav', 'static')
		sound:play()
	elseif self.x > 600 - 25 then
		self.x = self.x - self.vX * dt
		self.vX = -self.vX
		local sound = love.audio.newSource('sound/Brick_Hit.wav', 'static')
		sound:play()
	elseif self.y < 0 then
		self.y = self.y - self.vY * dt
		self.vY = -self.vY
		local sound = love.audio.newSource('sound/Brick_Hit.wav', 'static')
		sound:play()
	end
end

function Ball:ballCollidesPaddle(dt, Paddle)
	if isCollided(self, Paddle) then
		local sound = love.audio.newSource('sound/Paddle_Hit.wav', 'static')
		sound:play()
		scaleValue = math.abs((self.x + self.width/2 + 5) - (Paddle.x + Paddle.width/2))
		if self.x < Paddle.x + Paddle.width/2 then
			scaleValue = -scaleValue
		end
	
		self.vX = math.sin(math.rad(scaleValue)) * self.currentSpeed
		self.vY = -math.cos(math.rad(scaleValue)) * self.currentSpeed
		if self.y < WINDOW_HEIGHT/2 then
                        self.y = Paddle.y + Paddle.height
                elseif self.y > WINDOW_HEIGHT/2 then
                        self.y = Paddle.y - Paddle.height
                end

	end
end

function Ball:update(dt, Paddle)
	self:wallReact(dt)
	self:ballCollidesPaddle(dt, Paddle)
end

function Ball:changeSpeed(speed)
	self.vX = self.vX/self.currentSpeed
	self.vY = self.vY/self.currentSpeed
	self.currentSpeed = speed
	self.vX = self.vX * self.currentSpeed
	self.vY = self.vY * self.currentSpeed
end
