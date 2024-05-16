--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerPickupIdleState = Class{__includes = EntityIdleState}

function PlayerPickupIdleState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon
    self.objects = self.dungeon.currentRoom.objects

    self.entity:changeAnimation('pickupIdle-' .. self.entity.direction)
end

function PlayerPickupIdleState:enter(params)
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerPickupIdleState:update(dt)
    for k, object in pairs(self.objects) do
        if object.picked and not object.thrown then
            object.x = self.entity.x
            object.y = self.entity.y - 8
        end
    end

    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('pickupWalk')
    end

    if love.keyboard.wasPressed('return') then
        for i, object in ipairs(self.objects) do
            if object.picked then
                object:fire(self.dungeon, self.entity.direction, i)
                self.entity:changeState('idle')
            end
        end
        self.entity.pot = false
    end
end