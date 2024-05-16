--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x or WINDOW_WIDTH / 2
    self.y = y or WINDOW_HEIGHT / 2
    self.speed = 100
    self.xMax = self.x + TILE_SIZE * 4
    self.yMax = self.y + TILE_SIZE * 4
    self.xMin = self.x - TILE_SIZE * 4
    self.yMin = self.y - TILE_SIZE * 4
    self.width = def.width
    self.height = def.height

    self.picked = false
    self.thrown = false
    self.playerDirection = 'up'
    self.index = 1
    self.entities = {}
    self.objects = {}

    -- default empty collision callback
    self.onCollide = function() end
end

function GameObject:fire(dungeon, direction, i)
    self.playerDirection = direction
    self.index = i
    self.entities = dungeon.currentRoom.entities
    self.objects = dungeon.currentRoom.objects
    self.xMax, self.yMax, self.xMin, self.yMin = self.x + TILE_SIZE * 4, self.y + TILE_SIZE * 4, self.x - TILE_SIZE * 4, self.y - TILE_SIZE * 4
    self.thrown = true
end

function GameObject:update(dt)
    if self.thrown then
        local dxy = self.speed * dt

        if self.playerDirection == 'up' then
            self.y = self.y - dxy
        elseif self.playerDirection == 'down' then
            self.y = self.y + dxy
        elseif self.playerDirection == 'left' then
            self.x = self.x - dxy
        elseif self.playerDirection == 'right' then
            self.x = self.x + dxy
        end

        if self.playerDirection == 'left' then
            for k, enemy in pairs(self.entities) do
                if enemy:collides(self) then
                    enemy:damage(1)
                    self.thrown = false
                    table.remove(self.objects, self.index)
                end
            end
            if self.x <= self.xMin then
                self.thrown = false
                table.remove(self.objects, self.index)
            end
            if self.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
                self.thrown = false
                table.remove(self.objects, self.index)
            end
        elseif self.playerDirection == 'right' then
            for k, enemy in pairs(self.entities) do
                if enemy:collides(self) then
                    enemy:damage(1)
                    self.thrown = false
                    table.remove(self.objects, self.index)
                end
            end
            if self.x >= self.xMax then
                self.thrown = false
                table.remove(self.objects, self.index)
            end
            if self.x + self.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
                self.thrown = false
                table.remove(self.objects, self.index)
            end
        elseif self.playerDirection == 'up' then
            for k, enemy in pairs(self.entities) do
                if enemy:collides(self) then
                    enemy:damage(1)
                    self.thrown = false
                    table.remove(self.objects, self.index)
                end
            end
            if self.y <= self.yMin then
                self.thrown = false
                table.remove(self.objects, self.index)
            end
            if self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.height / 2 then 
                self.thrown = false
                table.remove(self.objects, self.index)
            end
        elseif self.playerDirection == 'down' then
            for k, enemy in pairs(self.entities) do
                if enemy:collides(self) then
                    enemy:damage(1)
                    self.thrown = false
                    table.remove(self.objects, self.index)
                end
            end
            if self.y >= self.yMax then
                self.thrown = false
                table.remove(self.objects, self.index)
            end
            local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE
            if self.y + self.height >= bottomEdge then
                self.thrown = false
                table.remove(self.objects, self.index)
            end
        end
        gSounds['door']:play()
    end
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end