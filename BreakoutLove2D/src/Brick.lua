Brick = BaseClass:Create()

function Brick:Create(x, y, vX, vY, image, quad, id)
	local o = BaseClass:Create(x, y, vX, vY, image)
	
	self.__index = self
        setmetatable(o, {index = BaseClass})
        setmetatable(o, self)
	o.isVisible = true
	o.id = id
	o.quad = quad
	o.isHit = false
	return o
end

function Brick:subtractIdAndDeleteBrick(Bricks)
	if self.id > 0 then
		self.id = self.id - 1
	end
	if self.id == 0 then		
		self.isVisible = false
		Bricks.bricksLeft = Bricks.bricksLeft - 1
	end	
end
