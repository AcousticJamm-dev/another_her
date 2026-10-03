local Player, super = Class(Player)

function Player:init(chara, x, y)
    super.init(self, chara, x, y)
end

function Player:getCurrentSpeed(running)
    if Mod.stamina.burnout then
		Mod.stamina.value = math.min(Mod.stamina.value + Mod.stamina.burnout_mult * DT, Mod.stamina.max_stamina)
		if Mod.stamina.value == Mod.stamina.max_stamina then
			Mod.stamina.burnout = false
		end
		return self:getBaseWalkSpeed()
	else
		local x, y, _ = self:checkWalkInput(1)
		if running and ((x ~= 0) or (y ~= 0)) then
			Mod.stamina.value = math.max(Mod.stamina.value - DT, 0)
			
			if Mod.stamina.value == 0 then
				Mod.stamina.burnout = true
			end
		else
			Mod.stamina.value = math.min(Mod.stamina.value + DT, Mod.stamina.max_stamina)
		end
	end
	
    return super.getCurrentSpeed(self, running)
end

function Player:draw()
    super.draw(self)
	
	if Mod.stamina.value < Mod.stamina.max_stamina then
		if not Mod.stamina.burnout then
			Draw.setColor(0.5, 0.5, 0.5)
		else
			Draw.setColor(0.5, 0, 0)
		end
		love.graphics.rectangle("fill", -10 + self.width/2, -self.height/2 + 8, 20, 4)
		if not Mod.stamina.burnout then
			Draw.setColor(1, 1, 1)
		else
			Draw.setColor(1, 0, 0)
		end
		love.graphics.rectangle("fill", -10 + self.width/2, -self.height/2 + 8, 20 * (Mod.stamina.value / Mod.stamina.max_stamina), 4)
	end
end

return Player