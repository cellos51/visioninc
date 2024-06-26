include("player_class/player_vision.lua")

DEFINE_BASECLASS("gamemode_base")

GM.Name = "Vision Inc."
GM.Author = "cellos51"
GM.Email = "gordieschiebel@gmail.com"
GM.Website = "N/A"

function GM:Initialize()
	-- Do stuff
end

function GM:PlayerNoClip(pl, on)
	return false -- No noclip. This is a campaign, not a sandbox.
end