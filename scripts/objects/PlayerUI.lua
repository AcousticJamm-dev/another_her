local PlayerUI, super = Class(Object)

-- Init Function
function PlayerUI:init()
    super.init(self)

    self.chara = Game.world.player
    self.tdrain = 0
    self.saudio = Sprite("ui/audio_warn", 15, 10)
    self.saudio:setScale(2)

    -- Add TP Bar
    self:addChild(TensionBar(-20, 70, false))

    -- Add Audio Warner
    self:addChild(self.saudio)
end

-- Update Function
function PlayerUI:update()
    super.update(self)

    -- Running Noise
    if (self.chara.run_timer >= 60) then
        Mod.noiselv = math.max(Mod.noiselv, 4)
    elseif (self.chara:isMoving()) then
        Mod.noiselv = math.max(Mod.noiselv, 2)
    else
        Mod.noiselv = math.max(Mod.noiselv, 1)
    end

    -- Audio Drag || NEEDS FIXING
    local audiolv = Mod.noiselv - 1
    if (audiolv ~= Mod.noiselv) then
        if (Mod.noiselv > 1) then
            self.tdrain = self.tdrain + 1

            -- Drain the audio
            if (self.tdrain >= 20) then
                self.tdrain = self.tdrain - 15
                Mod.noiselv = Mod.noiselv - 1
            end
        end
    end

    -- Audio
    self.saudio:setFrame(Mod.noiselv)
end

-- Draw Function
function PlayerUI:draw()
    super.draw(self)
end

return PlayerUI
