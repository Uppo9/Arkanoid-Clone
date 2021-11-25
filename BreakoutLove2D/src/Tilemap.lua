Tilemap = {}
--tiles is the table of positions to the atlas
function Tilemap:Create(atlas, tileMapX, tileMapY, tileWidth, tileHeight, levelMap)
	local o = {}
	self.__index = self
	setmetatable(o, self)
	
	o.atlas = love.graphics.newImage(atlas)
	o.tiles = createTileIdPositions(o.atlas, tileWidth, tileHeight)
	o.tileMapX = tileMapX
	o.tileMapY = tileMapY
	o.tileWidth = tileWidth
	o.tileHeight = tileHeight
	o.levelMap = levelMap
	o.tilemapWidth = #levelMap[1]
	o.tilemapHeight = #levelMap
	local x = tileMapX
	local y = tileMapY
	local bricksCounter = 0
	for i = 1, #levelMap do
		for j = 1, #levelMap[i] do 
			for p = 1, #o.tiles do 
				if levelMap[i][j] == o.tiles[p].id then --if tile in level is equal to a blue or any colored tile then give the brick a quad to the atlas
					table.insert(o, Brick:Create(x, y, 0, 0, 'graphics/Brick.png', o.tiles[p].quad, levelMap[i][j]))
					bricksCounter = bricksCounter + 1
				end

			end
			x = x + tileWidth
		end
		x = tileMapX 
		y = y + tileHeight 
	end
	o.howManyBricks = bricksCounter
	return o
end

function Tilemap:draw()
	for i = 1, #self do
		if self[i].isVisible then
			love.graphics.draw(self.atlas, self[i].quad, self[i].x, self[i].y)
		end
	end
end

function Tilemap:update(dt)
	for i = 1, #self do
		for j = 1, #self.tiles do
			if self[i].id == self.tiles[j].id then
				self[i].quad = self.tiles[j].quad
			end
		end
	end
end

