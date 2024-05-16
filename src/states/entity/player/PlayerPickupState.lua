--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerPickupState = Class{__includes = BaseState}

function PlayerPickupState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.entity.offsetY = 5
    self.entity.offsetX = 0

    -- sword-left, sword-up, etc
    self.entity:changeAnimation('pickup-' .. self.entity.direction)

    -- pickup sound
end

function PlayerPickupState:update(dt)

    local objects = {}
    for k, object in pairs(self.dungeon.currentRoom.objects) do
        if ((self.entity.direction == 'left' and self.entity.x > object.x and self.entity.x < object.x + TILE_SIZE + 5) or
            (self.entity.direction == 'right' and self.entity.x < object.x and self.entity.x > object.x - self.entity.width - 5) or
            (self.entity.direction == 'up' and self.entity.y > object.y and self.entity.y < object.y + TILE_SIZE / 3 + 5) or
            (self.entity.direction == 'down' and self.entity.y < object.y and self.entity.y > object.y - self.entity.height - 5)) and
            object.type == 'pot' then
                object.picked = true
                gSounds['lift']:play()
        end
    end

    -- if we've fully elapsed through one cycle of animation, change back to idle state
    if self.entity.currentAnimation.timesPlayed > 0 then
        self.entity.currentAnimation.timesPlayed = 0
        self.entity:changeState('pickupIdle')
    end
end


function PlayerPickupState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
end