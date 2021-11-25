Powerup = {}

function Powerup:Create(x, y, characteristics)
	local vY = 0
	local vX = 0
	local o = BaseClass:Create(x, y, vX, vY, characteristics.texture)
	self.__index = self
	setmetatable(o, {index = BaseClass})
	setmetatable(o, self)
	o.isVisible = true
	o.bounce = characteristics.bounce
	o.slow = characteristics.slow
	o.fast = characteristics.fast
	return o
end

function Powerup:update(dt)
	if self.isVisible then
		self.y = self.y + GRAVITY * dt
		if self.y > WINDOW_HEIGHT then--remove powerup from play
			self.isVisible = false
		end
	end
end

function Powerup:draw()
	love.graphics.draw(self.image, self.x, self.y)
end
