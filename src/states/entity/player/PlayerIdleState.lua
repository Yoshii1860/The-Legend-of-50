--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerIdleState:update(dt)

    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('swing-sword')
    end

    if love.keyboard.wasPressed('return') then
        for k, object in pairs(self.dungeon.currentRoom.objects) do
            if object.solid then
                if (self.entity.direction == 'left' and self.entity.x > object.x and self.entity.x < object.x + TILE_SIZE + 5)
                or (self.entity.direction == 'right' and self.entity.x < object.x and self.entity.x > object.x - self.entity.width - 5)
                or (self.entity.direction == 'up' and self.entity.y > object.y and self.entity.y < object.y + TILE_SIZE / 3 + 5)
                or (self.entity.direction == 'down' and self.entity.y < object.y and self.entity.y > object.y - self.entity.height - 5) then
                    if self.entity.direction == 'left' or self.entity.direction == 'right' then
                        self.entity.y = object.y - TILE_SIZE / 3
                    elseif self.entity.direction == 'up' or self.entity.direction == 'down' then
                        self.entity.x = object.x
                    end
                    self.entity.pot = true
                    self.entity:changeState('pickup')
                end
            end
        end
    end
end

