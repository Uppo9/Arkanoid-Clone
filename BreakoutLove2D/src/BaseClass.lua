BaseClass = {x = 0, y = 0, vX = 0, vY = 0} --default values

function BaseClass:Create(x, y, vX, vY, image)
	local o = {}
        setmetatable(o, self)
        self.__index = self

	o.x = x -- the x position
	o.y = y -- the y position
	o.vX = vX --the change in x
	o.vY = vY -- the change in y
	if image ~= nil then
		o.image = love.graphics.newImage(image) -- the image for whatever
		o.height = o.image:getHeight()
		o.width = o.image:getWidth()
		o.left = o.x
        	o.right = o.left + o.width
        	o.top = o.y
       	 	o.bottom = o.top + o.height
	end
	return o
end

function BaseClass:draw()
	love.graphics.draw(self.image, math.floor(self.x), math.floor(self.y))
end
