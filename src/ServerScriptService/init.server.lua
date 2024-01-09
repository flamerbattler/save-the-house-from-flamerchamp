local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Matter = require(ReplicatedStorage.Packages.Matter)

local world = Matter.World.new()

local loop = Matter.Loop.new(world) -- This makes Loop pass the world to all your systems.

local systems = {}
for _, child in ipairs(script.Systems:GetChildren()) do
	if child:IsA("ModuleScript") then
		table.insert(systems, require(child))
	end
end

loop:scheduleSystems(systems)

loop:begin({
	default = RunService.Heartbeat
})