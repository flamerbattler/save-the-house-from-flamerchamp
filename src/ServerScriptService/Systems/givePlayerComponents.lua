local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Components = require(ReplicatedStorage.Shared.Components)
local Matter = require(ReplicatedStorage.Packages.Matter)

local function givePlayerComponents(world)
	for _, player in ipairs(Players:GetPlayers()) do
		for _, character in Matter.useEvent(player, "CharacterAdded") do
			world:spawn(
				Components.Teammate({
					teammate = player
				}),
				Components.Model({
					model = character
				}),
				Components.Health({
					value = 100
				})
			)
		end
	end

	-- players can die
	for id in world:query(Components.Teammate):without(Components.Model) do
		world:despawn(id)
	end
end

return givePlayerComponents