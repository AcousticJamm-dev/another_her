function Mod:init()
    -- Bleh
    love.window.setMode(960, 720)

    -- Generic Globals
    Mod.noiselv = 1

    -- Set the window title
	love.window.setTitle("ANOTHER_HER")

    -- Logger bullshit
    Mod.logger = Logger("My Project", ConsoleFormats.GREEN)
    Mod.logger:info("Loaded " .. self.info.name .. "!")

    -- Register a custom Tiled event.
    Game:registerEvent("squeak", function(data)
        return Squeak(data.x, data.y, {data.width, data.height, data.polygon})
    end)

    -- Create the main music
    Mod.mus1 = Music("core", 0.9, 0.5)
    Mod.mus1:setLooping(true)
    Mod.mus1:play()

    -- Create the main ambience
    Mod.mus2 = Assets.getSound("paper_surf"):clone()
    Mod.mus2:setLooping(true)
    Mod.mus2:setPitch(0.3)
    Mod.mus2:setVolume(1.1)
    Mod.mus2:play()

    -- Create the FROZEN ambience
    --Mod.mus3 = Assets.getSound("voice/noelle"):clone()
    --Mod.mus3:setLooping(true)
    --Mod.mus3:setPitch(0.12)
    --Mod.mus3:setVolume(1)
    --Mod.mus3:play()
end

function Mod:postInit()
    -- Adds the PlayerUI object
    Game.stage:addChild(PlayerUI())
end

-- Custom footstep SFX handler
function Mod:onFootstep()
    local step = 0
    local vol = (Game.world.player.run_timer >= 60) and 1.75 or 1
	step = step % 2 + 1
	Assets.playSound("step" .. step, vol)
end