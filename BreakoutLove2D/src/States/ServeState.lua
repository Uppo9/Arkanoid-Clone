ServeState = {}

function ServeState:load(variables)
	self.Paddle = variables.Paddle
	self.Ball = variables.Ball
	self.Bricks = variables.Bricks
	self.lives = variables.lives
	self.score = variables.score
	BALLSPEED = 600
	self.Paddle.x = WINDOW_WIDTH/2 - 300
	self.Paddle.y = WINDOW_HEIGHT - 100
	self.Ball.vX = 0
	self.Ball.vY = 0
	self.Ball.x = self.Paddle.x + self.Paddle.width/2 - self.Ball.width/2
	self.Ball.y = self.Paddle.y - self.Paddle.height

end

function ServeState:update(dt)
	if gKey == 'return' then
		local angle = -70
		angle = math.random(-60, 60)
		self.Ball.vX = math.sin(math.rad(angle)) * BALLSPEED
		self.Ball.vY = -math.cos(math.rad(angle)) * BALLSPEED
		gKey = nil
		gStateMachine:change('playstate', {
			Paddle = self.Paddle,
			Ball = self.Ball,
			Bricks = self.Bricks,
			lives = self.lives,
			score = self.score,
		})
	end
end

function ServeState:draw()
	love.graphics.printf('Level: ' .. tostring(self.Bricks.currentLevel) .. '\n\nBricks\nDestroyed: \n' .. tostring(self.score) .. '\n\nLives: '.. self.lives, 600, 50, 500, 'center')
	love.graphics.rectangle('line', 603, 10, 20, 1010)
	self.Paddle:draw()
	self.Bricks:draw()
end
