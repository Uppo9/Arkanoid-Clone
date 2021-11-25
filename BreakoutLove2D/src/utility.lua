function distance(a, b)
        local distance = ((a.x - b.x) * (a.x - b.x)) + ((a.y - b.y) * (a.y - b.y))
        math.sqrt(distance)
        return distance
end

function distance(x1, y1, x, y)
	local distance = (((x1 - x) * (x1 - x)))
	math.sqrt(distance)
	return distance
end

function isCollided(a, b)
        if a.x < b.x + b.width and b.x < a.x + a.width and a.y < b.y + b.height and b.y < a.y + a.height then
                return true
        end

        return false
end

Tiles = {}

function Tiles:Create(id, quad)
	local o = {}
	self.__index = self
	setmetatable(o, self)
	o.id = id
	o.quad = quad
	return o
end

function createTileIdPositions(atlas, tileWidth, tileHeight)
	local tiles = {}
	local id = 1
	for y = 0, atlas:getHeight(), tileHeight do
		for x = 0, atlas:getWidth(), tileWidth do
			local quad = love.graphics.newQuad(x, y, tileWidth, tileHeight, atlas:getDimensions())
			table.insert(tiles, Tiles:Create(id, quad))
			id = id + 1
		end
	end
	return tiles
end

function correctPositionAndChangeVelocityX(Brick, Ball)
	if Ball.bounceOffBrick then
		if Ball.x > Brick.x then--up
			Ball.x = Ball.x + 10
			Ball.vX = -Ball.vX
		elseif Ball.x < Brick.x then--down
			Ball.x = Ball.x - 10
			Ball.vX = -Ball.vX
		end
	end
end

function correctPositionAndChangeVelocityY(Brick, Ball)
	if Ball.bounceOffBrick then
		if Ball.y > Brick.y then--up
			Ball.y = Ball.y + 10
			Ball.vY = -Ball.vY
		elseif Ball.y < Brick.y then--down
			Ball.y = Ball.y - 10
			Ball.vY = -Ball.vY
		end
	end
end
