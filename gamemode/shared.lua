GM.Name     = "Garrychet (aka. Ricochet 2)"
GM.Author   = "Nightmare & ptown2"
GM.Email    = "xptown2x@gmail.com"
GM.Website  = ""
GM.Version 	= 1.02

include("sh_colors.lua")
include("sh_global.lua")
include("obj_server_extend.lua")

ROUND = 0
TIMELIMIT = 0
ROUNDEND = false

function GM:PrecacheResources()
	for _, filename in pairs(file.Find("sound/ricochet/*.*", "GAME")) do
		util.PrecacheSound("sound/ricochet/" ..filename)
	end
	for name, mdl in pairs(player_manager.AllValidModels()) do
		util.PrecacheModel(mdl)
	end
end

function GM:LoadGametypes()
	local included = {}
	local modes = file.Find(self.FolderName.."/gamemode/gametypes/*.lua", "LUA")
	table.sort(modes)

	for i, filename in ipairs(modes) do
		AddCSLuaFile("gametypes/" ..filename)
		GAMETYPE = {}
		include("gametypes/" ..filename)

		if GAMETYPE.Name and GAMETYPE.Index then
			GAMETYPES[GAMETYPE.Index] = GAMETYPE
			MsgN("GAMETYPE " ..filename.. " has been registered!")
		else
			MsgN("GAMETYPE "..filename.." has incompleted member(s)!")
		end

		included[filename] = GAMETYPE
		GAMETYPE = nil
	end
end

function ValidVariable(meta, var)
	if not CHECKMETA[type(meta)] then return end

	if meta and meta[var] then
		return meta[var]
	end
end

function ValidFunction(meta, funcname, ...)
	if not CHECKMETA[type(meta)] then return end

	if meta and meta[funcname] then
		return meta[funcname](meta, ...)
	end
end

function GM:RespawnPlayers()
	for _, pl in pairs(player.GetAll()) do
		pl:Spawn()
		pl:SetFrags(0)
		pl:SetDeaths(0)
		pl:SetLastAttacker(nil)
		pl:RemoveAllStatus(true, true)
	end
end

function GM:SetGlobalVars()
	SetGlobalInt("rc_round", 0)
	SetGlobalInt("rc_gamestate", STATE_WAIT)
	SetGlobalInt("rc_timelimit", CurTime() + WAIT_TIME)
	SetGlobalBool("rc_roundend", false)
	SetGlobalString("rc_gametype", "dm")
	
	TIMELIMIT = self:GetTime()
end

function GM:RestartGame()
	self:StartRound()
	self:RespawnPlayers()
end

function GM:NotifyPlayers(string)
	for _, pl in pairs(player.GetAll()) do
		pl:ChatPrint(string)
	end
end

function util.ToMinutesSeconds(seconds)
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

    return string.format("%02d:%02d", minutes, math.ceil(seconds))
end

function util.ToMinutesSecondsMilliseconds(seconds)
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

	local milliseconds = math.floor(seconds % 1 * 100)

    return string.format("%02d:%02d.%02d", minutes, math.ceil(seconds), milliseconds)
end

function util.ToSecondsMilliseconds(seconds)
	local milliseconds = math.abs(math.ceil(seconds % 1 * 100))

    return string.format("%01d.%00d", math.ceil(seconds), milliseconds)
end

function string.AndSeparate(list)
	local length = #list
	if length <= 0 then return "" end
	if length == 1 then return list[1] end
	if length == 2 then return list[1].." and "..list[2] end

	return table.concat(list, ", ", 1, length - 1)..", and "..list[length]
end