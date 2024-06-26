AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_pixelate.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

DEFINE_BASECLASS("gamemode_base")

function GM:PlayerSpawn(pl, transiton)
	pl:Give("lighter")

	player_manager.SetPlayerClass(pl, "player_vision")

	BaseClass.PlayerSpawn(self, pl, transiton)
end