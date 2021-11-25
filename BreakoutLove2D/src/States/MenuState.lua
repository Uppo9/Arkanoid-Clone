MenuState = {}

function MenuState:load(variables)
	love.graphics.setFont(zorqueFont)
	self.Paddle = Paddle:Create(WINDOW_WIDTH/2 - 50, WINDOW_HEIGHT - 100, PADDLESPEED, PADDLESPEED, 'graphics/Paddle.png')
	self.Ball = Ball:Create(self.Paddle.x + self.Paddle.width, self.Paddle.y - self.Paddle.height - 2, 0, BALLSPEED, 'graphics/Ball.png')
	self.lives = 3
	self.score = 0
	--declare levels in levels file
	local level =
	{
		{5, 4, 4, 4, 4, 4, 4},
	}
	self.Bricks = LevelManager:Create('graphics/bricks.png', 0, 200, 50, 35, levelMaps)
end

function MenuState:update(dt)
	if gKey == 'return' then
		gKey = nil
		gStateMachine:change('servestate', {
			Paddle = self.Paddle,
			Ball = self.Ball,
			Bricks = self.Bricks,
			lives = self.lives,
			score = self.score,
		})
	end
end

function MenuState:draw()
	love.graphics.printf('Brickbuster!\n\n\n\nPress Enter To Begin Game', 47, 150, 500, 'center')
end
