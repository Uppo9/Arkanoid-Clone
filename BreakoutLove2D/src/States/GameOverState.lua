GameOver = {}

function GameOver:load(variables)
	love.graphics.setFont(zorqueFont)
	self.Paddle = Paddle:Create(WINDOW_WIDTH/2, WINDOW_HEIGHT - 100, PADDLESPEED, PADDLESPEED, 'graphics/Paddle.png')
	self.Ball = Ball:Create(self.Paddle.x + self.Paddle.width/2 - 9, self.Paddle.y - self.Paddle.height - 2, BALLSPEED, BALLSPEED, 'graphics/Ball.png')
	self.lives = 3
	self.score = 0
	local level =
	{
		                --the color of the brick at the beginning 
		{
			{1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1},
			{1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1},
			{1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1},
			{1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1},
			{1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1},
		},
	--how many hits it takes to hit each brick
		{
			{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
			{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
			{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
			{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
			{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
		},
	}
	self.Bricks = LevelManager:Create('graphics/bricks.png', 0, 200, 50, 35, levelMaps)
end

function GameOver:update(dt)
	if gKey == 'return' then
		gKey = nil
		gStateMachine:change('servestate', {
			Paddle = self.Paddle,
			Ball = self.Ball,
			lives = self.lives,
			Bricks = self.Bricks,
			score = self.score,
		})
	end
end

function GameOver:draw()
	love.graphics.printf('Game Over\n\nPress Enter To Play Again!', 47, 200, 500, 'center')	
end
