GM.Name     = "Garrychet (aka. Ricochet 2)"
GM.Author   = "Nightmare & ptown2"
GM.Email    = "xptown2x@gmail.com"
GM.Website  = ""
GM.Version 	= 100

include("sh_colors.lua")
include("sh_global.lua")

function GM:PrecacheResources()
	for _, filename in pairs(file.Find("sound/ricochet/*.*", "GAME")) do
		util.PrecacheSound("sound/ricochet/" ..filename)
	end
	for name, mdl in pairs(player_manager.AllValidModels()) do
		util.PrecacheModel(mdl)
	end
end

function GM:SetupGame()
	SetGlobalInt("rc_round", 1)
	SetGlobalInt("rc_timelimit", CurTime() + DEATHMATCH_TIMELIMIT)
	SetGlobalBool("rc_roundend", false)
end

function GM:RestartGame()
	game.CleanUpMap()

	SetGlobalInt("rc_round", GetGlobalInt("rc_round") + 1)
	SetGlobalInt("rc_timelimit", CurTime() + DEATHMATCH_TIMELIMIT)
	SetGlobalBool("rc_roundend", false)

	for k, v in pairs(player.GetAll()) do 
		v:Spawn()
		v:SetFrags(0)
		v:SetDeaths(0)
		v:SetDTInt(0, 0)
		v:SetDTInt(1, 0)
	end 
end