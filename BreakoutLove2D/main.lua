require 'src/Dependencies'

function love.load()
	math.randomseed(os.time())
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
	gStateMachine = StateMachine:Create({
	['menustate'] = MenuState,
	['playstate'] = PlayState,
	['servestate'] = ServeState,
	['gameover'] = GameOver
	})
	gSounds = {
		['brick_hit'] = love.audio.newSource('sound/Brick_Hit.wav', 'static'),
		['paddle_hit'] = love.audio.newSource('sound/Paddle_Hit.wav', 'static')
	}
	gStateMachine:change('menustate')
	gKey = nil
	gKeyReleased = false
end

function love.keypressed(key)
	gKey = key
	gKeyReleased = false
end

function love.keyreleased(key, uni)
	gKey = nil
	gKeyReleased = true
end

function love.update(dt)
	gStateMachine:update(dt)
end

function love.draw()
	gStateMachine:draw()
end
