PlayState = {}

function PlayState:load(variables)
	self.Paddle = variables.Paddle
	self.Ball = variables.Ball
	self.lives = variables.lives
	self.score = variables.score
	self.Bricks = variables.Bricks
	self.powerup = {}
	self.pause = true
	self.speedTimer = 0
	self.bounceOffBricksTimer = 0
end

function PlayState:update(dt)
	self.speedTimer = self.speedTimer + dt
	self.bounceOffBricksTimer = self.bounceOffBricksTimer + dt
	if gKey == 'p' then
		self.pause = false
	elseif gKey == 'u' then
		self.pause = true
	end

	if self.pause then
		self.Bricks:update(dt)
		self.Ball:update(dt, self.Paddle)
		self.Paddle:update(dt, self.Ball)
		
		for i = 1, #self.powerup do
			self.powerup[i]:update(dt)
			if isCollided(self.powerup[i], self.Paddle) and self.powerup[i].isVisible then
				if self.powerup[i].bounce then
					self.Ball.bounceOffBrick = false
					self.bounceOffBricksTimer = 0
				elseif self.powerup[i].fast then
					self.Ball:changeSpeed(FASTBALLSPEED)
					self.speedTimer = 0
				elseif self.powerup[i].slow then
					self.Ball:changeSpeed(SLOWBALLSPEED)
					self.speedTimer = 0
				end

				self.powerup[i].isVisible = false 
			end
		end
		if self.speedTimer >= SPEEDPOWERUPTIMELIMIT then
			self.Ball:changeSpeed(BALLSPEED)
                end
                if self.bounceOffBricksTimer >= NOBOUNCETIMELIMIT then
			self.Ball.bounceOffBrick = true
                end

		--serve ball if player dies once
		if self.Ball.y > WINDOW_HEIGHT and self.lives > 0 then
			self.lives = self.lives - 1
			self.Ball:changeSpeed(BALLSPEED)
			gStateMachine:change('servestate', {
				Paddle = self.Paddle,
				Ball = self.Ball,
				Bricks = self.Bricks,
				lives = self.lives,
				score = self.score,
			})
		--be done with game if the players lives equal 0
		elseif self.lives == 0 then
			gStateMachine:change('gameover', {
				Paddle = self.Paddle,
				Ball = self.Ball,
				lives = self.lives,
				score = self.score,
				Bricks = self.Bricks,
			})
		--did all levels, go back to menustate
		elseif self.Bricks.currentLevel == self.Bricks.howManyLevels + 1 then
			gStateMachine:change('menustate')
		--go to next level when all the bricks are cleared
		end
		if self.Bricks.bricksLeft == 0 then
			self.Bricks:nextLevel()
			gStateMachine:change('servestate', {
                        	Paddle = self.Paddle,
                        	Ball = self.Ball,
                        	Bricks = self.Bricks,
                        	lives = self.lives,
                        	score = self.score,
                	})
		end
		--do the x seperetly from the y
		self.Ball.x = self.Ball.x + self.Ball.vX * dt --update ball position
		for i = 1, #self.Bricks.level do -- do for all the bricks
			if isCollided(self.Bricks.level[i], self.Ball) and self.Bricks.level[i].isVisible and self.Bricks.level[i].id ~= 0 and not self.Bricks.level[i].isHit then
				local sound = love.audio.newSource('sound/Brick_Hit.wav', 'static')
				sound:play()
				if math.random(POWERUPSPAWNCHANCE) == 1 then
					table.insert(self.powerup, Powerup:Create(self.Bricks.level[i].x, self.Bricks.level[i].y, powerups[math.random(3)]))
				end
				correctPositionAndChangeVelocityX(self.Bricks.level[i], self.Ball)
				self.Bricks.level[i]:subtractIdAndDeleteBrick(self.Bricks)
				self.score = self.score + 1
				self.Bricks.level[i].isHit = true
			elseif not isCollided(self.Bricks.level[i], self.Ball) then
				self.Bricks.level[i].isHit = false
			end
		end
		--do the y sepretly from the x
		self.Ball.y = self.Ball.y + self.Ball.vY * dt
		for i = 1, #self.Bricks.level do
			if isCollided(self.Bricks.level[i], self.Ball) and self.Bricks.level[i].isVisible and self.Bricks.level[i].id ~= 0  and not self.Bricks.level[i].isHit then --both collide at the same time
				local sound = love.audio.newSource('sound/Brick_Hit.wav', 'static')
				sound:play()
				if math.random(POWERUPSPAWNCHANCE) == 1 then
					table.insert(self.powerup, Powerup:Create(self.Bricks.level[i].x, self.Bricks.level[i].y, powerups[math.random(3)]))
				end

				local upBrickYDistance = distance(self.Bricks.level[i].x + self.Bricks.level[i].width, self.Bricks.level[i].y, self.Ball.x, self.Ball.y)
				local downBrickYDistance = distance(self.Bricks.level[i].x + self.Bricks.level[i].width, self.Bricks.level[i].y, self.Ball.x + self.Ball.width, self.Ball.y)
				if upBrickYDistance > downBrickYDistance or upBrickYDistance < downBrickYDistance and isCollided(self.Bricks.level[i], self.Ball) and i == self.Bricks.level.howManyBricks or i ~= self.Bricks.level.howManyBricks and self.Bricks.level[i + 1].id == 0 and not self.Bricks.level[i + 1].isVisible then
					self.Bricks.level[i]:subtractIdAndDeleteBrick(self.Bricks)
					correctPositionAndChangeVelocityY(self.Bricks.level[i], self.Ball)
				elseif upBrickYDistance < downBrickYDistance and  i ~= self.Bricks.level.howManyBricks and isCollided(self.Bricks.level[i + 1], self.Ball) and self.Bricks.level[i + 1].isVisible and self.Bricks.level[i + 1].id ~= 0 then
					self.Bricks.level[i + 1]:subtractIdAndDeleteBrick(self.Bricks)
					correctPositionAndChangeVelocityY(self.Bricks.level[i + 1], self.Ball)
				end
				self.score = self.score + 1
				self.Bricks.level[i].isHit = true
			elseif not isCollided(self.Bricks.level[i], self.Ball) then
				self.Bricks.level[i].isHit = false
			end
		end
	end
end

function PlayState:draw()
	
	love.graphics.printf('Level: ' .. tostring(self.Bricks.currentLevel) .. '\n\nBricks\nDestroyed: \n' .. tostring(self.score) .. '\n\nLives: '.. self.lives, 600, 50, 500, 'center')
	love.graphics.rectangle('line', 603, 10, 20, 1010)
	self.Paddle:draw()
	self.Ball:draw()
	self.Bricks:draw()
	for i = 1, #self.powerup do
		if self.powerup[i].isVisible then
			self.powerup[i]:draw()
		end
	end
end
