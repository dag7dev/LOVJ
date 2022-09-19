debug = require "debug"

lick = require "lib/lick"
res = require "lib/resources"
screen = require "lib/screen"
timer = require "lib/timer"
resources = require "lib/resources"
controls = require "lib/controls"
connections = require "lib/connections"
dispatcher = require "lib/dispatcher"

cfg_patches = require "lib/cfg/cfg_patches"
cfg_shaders = require "lib/cfg/cfg_shaders"
cfg_automations = require "lib/cfg/cfg_automations"

local defaultPatch = cfg_patches.defaultPatch
patch = require(defaultPatch)
lick.updateCurrentlyLoadedPatch( defaultPatch .. ".lua")

local fps = 0
-- lick reset enable
lick.reset = true

--  hot reload
function love.load()
	-- Init screen
	screen.init()
	-- Init timer
	timer.init()
	-- Init resources
	resources.init()
	-- Init Patch
	patch.init()
	-- Init socket
	connections.init()
	-- Init Shaders globals
	cfg_shaders.assignGlobals()

end


-- Main draw cycle, called once every frame (depends on vsync)
function love.draw()

	-- if in high res upscaling mode, then apply scale function here
	if screen.isUpscalingHiRes() then
		love.graphics.scale(screen.Scaling.RatioX, screen.Scaling.RatioY)
	end

	-- draw patch
	patch.draw()

	-- calculate fps
	fps = love.timer.getFPS()
end


-- Main update cycle, executed as fast as possible
function love.update()
	timer.update()  -- update timer
	-- Console management
	if timer.consoleTimer() then
		print("FPS:", fps)
	end

	controls.handleGeneralControls()  -- evaluate general controls

	local response_data = connections.sendRequests()  -- request data from UDP connections
	dispatcher.update(response_data)  -- TODO implement this
	patch.update()
end