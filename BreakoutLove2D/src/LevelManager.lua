LevelManager = {}

function LevelManager:Create(atlas, tileMapX, tileMapY, tileWidth, tileHeight, levelMaps)
	local o = {}
	self.__index = self
	setmetatable(o, self)
	o.imageLocation = atlas
	o.currentLevel = 1
	o.tileMapX = tileMapX
	o.tileMapY = tileMapY
	o.tileWidth = tileWidth
	o.tileHeight = tileHeight
	o.levelMaps = levelMaps
	o.howManyLevels = #o.levelMaps
	o.level = Tilemap:Create(atlas, tileMapX, tileMapY, tileWidth, tileHeight, o.levelMaps[1])
	o.bricksLeft = o.level.howManyBricks
	return o
end

function LevelManager:draw()	
	self.level:draw()
end

function LevelManager:update(dt)
	self.level:update(dt)
end

function LevelManager:changeLevel(id)
	self.level = Tilemap:Create(self.imageLocation, self.tileMapX, self.tileMapY, self.tileWidth, self.tileHeight, levels[id])
end

function LevelManager:nextLevel()
	self.currentLevel = self.currentLevel + 1
	if self.currentLevel ~= #self.levelMaps + 1 then
		self.level = Tilemap:Create(self.imageLocation, self.tileMapX, self.tileMapY, self.tileWidth, self.tileHeight, self.levelMaps[self.currentLevel])
	end
	self.bricksLeft = self.level.howManyBricks
end
