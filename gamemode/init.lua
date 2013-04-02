--[[
	Garrychet (aka. Ricochet 2)
	Made by: Nightmare
	Continued by: ptown2
	
	A gmod13 redo of the Ricochet game

TODO:
	- Setup multi-powerups IE get power disc and then get ice disc
]]
AddCSLuaFile()
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")

AddCSLuaFile("shared.lua")
AddCSLuaFile("sh_global.lua")
AddCSLuaFile("sh_colors.lua")

AddCSLuaFile("obj_entity_extend.lua")
AddCSLuaFile("obj_player_extend.lua")
AddCSLuaFile("obj_weapon_extend.lua")


include("shared.lua")

include("obj_player_extend.lua")
include("obj_entity_extend.lua")
include("obj_weapon_extend.lua")

function GM:AddResources()
	resource.AddFile("materials/ricochet/640_discblue.vtf")
	resource.AddFile("materials/ricochet/640_discblue.vmt")
	resource.AddFile("materials/ricochet/640_discblue2.vtf")
	resource.AddFile("materials/ricochet/640_discblue2.vmt")
	resource.AddFile("materials/ricochet/640_discgray.vtf")
	resource.AddFile("materials/ricochet/640_discgray.vmt")
	resource.AddFile("materials/ricochet/640_discred.vtf")
	resource.AddFile("materials/ricochet/640_discred.vmt")
	resource.AddFile("materials/ricochet/640_discred2.vtf")
	resource.AddFile("materials/ricochet/640_discred2.vmt")
	resource.AddFile("materials/ricochet/640_freeze.vtf")
	resource.AddFile("materials/ricochet/640_freeze.vmt")
	resource.AddFile("materials/ricochet/640_frozen.vtf")
	resource.AddFile("materials/ricochet/640_frozen.vmt")
	resource.AddFile("materials/ricochet/640_fire.vtf")
	resource.AddFile("materials/ricochet/640_fire.vmt")
	resource.AddFile("materials/ricochet/640_fast.vtf")
	resource.AddFile("materials/ricochet/640_fast.vmt")

	resource.AddFile("sound/ricochet/decap.wav")
	resource.AddFile("sound/ricochet/disc_fire.wav")
	resource.AddFile("sound/ricochet/disc_hit1.wav")
	resource.AddFile("sound/ricochet/disc_hit2.wav")
	resource.AddFile("sound/ricochet/powerup.wav")
	resource.AddFile("sound/ricochet/pspawn.wav")
	resource.AddFile("sound/ricochet/triggerjump.wav")
	resource.AddFile("sound/ricochet/scream1.wav")
	resource.AddFile("sound/ricochet/scream2.wav")
	resource.AddFile("sound/ricochet/scream3.wav")
	
	resource.AddFile("models/ricochet/ricochet_disc.mdl")
end

function GM:Initialize()
	self:AddResources()
	self:PrecacheResources()
	self:SetupGame()
end

function GM:InitPostEntity()
	for k, v in pairs(ents.FindByClass("rc_gameinfo")) do
		SetGlobalInt("GameType", v:GetGameType() or GAMETYPE_DEATHMATCH)
		print("gametype: "..v:GetGameType() or GAMETYPE_DEATHMATCH)
	end
end

function GM:PlayerInitialSpawn(pl)
	local rawmodelname = pl:GetInfo("cl_playermodel")
	local modelname = player_manager.TranslatePlayerModel(rawmodelname)
	modelname = modelname or "models/player/alyx.mdl"
	pl:SetModel(modelname)

	if GetGlobalInt("GameType") == GAMETYPE_DEATHMATCH then
		pl:SetTeam(TEAM_DEATHMATCH)
	end
	
	if GetGlobalInt("GameType") == GAMETYPE_TEAMDEATHMATCH then
		local blueteam = team.NumPlayers(TEAM_BLUE)
		local redteam = team.NumPlayers(TEAM_RED)

		if blueteam > redteam then
			pl:SetTeam(TEAM_RED)
		elseif redteam > blueteam then
			pl:SetTeam(TEAM_BLUE)
		else
			local bluescore = team.GetScore(TEAM_BLUE)
			local redscore = team.GetScore(TEAM_RED)

			if bluescore > redscore then
				pl:SetTeam(TEAM_RED)
			elseif redscore > bluescore then
				pl:SetTeam(TEAM_BLUE)
			else
				pl:SetTeam(math.random(TEAM_BLUE,TEAM_RED))
			end
		end

		pl:SetColor(team.GetColor(pl:Team()))
	end
end

--[[function GM:Think()
	for k, v in pairs(player.GetAll()) do
		if v:GetDTFloat(2) < CurTime() and v:GetDTInt(2) ~= 0 or v:Health() <= 0 or not v:Alive() then --status effect duration
			v:SetWalkSpeed(150)
			v:SetRunSpeed(150)
			v:SetMaxSpeed(150)
			v:SetMaterial()
			v:SetDTInt(2, 0)
		end
	end
end]]

function GM:PlayerSpawn(pl)
	pl:SetWalkSpeed(150)
	pl:SetRunSpeed(150)
	pl:SetMaxSpeed(150)
	pl:SetJumpPower(0)
	pl:SetMaterial()
	pl:SetLastAttacker(nil)
	pl:SetAlive(true)
	
	self:PlayerLoadout(pl)
	
	local effectdata = EffectData()
		effectdata:SetOrigin(pl:GetPos())
	util.Effect("spawneffect", effectdata, true)
end

function GM:PlayerLoadout(pl)
	pl:Give("weapon_disc")
end

function GM:EntityTakeDamage(pl, dmginfo)
	if dmginfo:IsFallDamage() then dmginfo:SetDamage(0) end

	if dmginfo:GetAttacker() ~= pl and pl:GetLastAttacker():IsPlayer() and (pl:GetLastAttackerTime() + 3) > CurTime() then
		dmginfo:SetAttacker(pl:GetLastAttacker())
	end
end

function GM:DoPlayerDeath(pl, attacker, dmginfo)
	pl:CreateRagdoll()
	pl:AddDeaths(1)
	pl:SetStatus(0)
	pl:SetAlive(false)

	local dmgtype = dmginfo:GetDamageType()

	if dmgtype == POWERUP_FIRE then
		local effectdata = EffectData()
			effectdata:SetOrigin(pl:LocalToWorld(pl:OBBCenter()))
			effectdata:SetEntity(pl)
		util.Effect("fire_death", effectdata, true)
	elseif dmgtype == POWERUP_ELEC then
		local effectdata = EffectData()
			effectdata:SetOrigin(pl:LocalToWorld(pl:OBBCenter()))
			effectdata:SetEntity(pl)
		util.Effect("electric_death", effectdata, true)
	elseif dmgtype == POWERUP_FREEZE then
		local effectdata = EffectData()
			effectdata:SetOrigin(pl:LocalToWorld(pl:OBBCenter()))
			effectdata:SetEntity(pl)
		util.Effect("ice_death", effectdata, true)
	end

	if attacker:IsValid() and attacker:IsPlayer() and dmginfo:GetInflictor():GetClass() == "projectile_disc_power" then
		local effectdata = EffectData()
			effectdata:SetOrigin(pl:LocalToWorld(pl:OBBCenter()))
			effectdata:SetEntity(pl)
		util.Effect("decapitation_death", effectdata, true)
	end

	if dmginfo:GetAttacker():GetClass() == "trigger_hurt" then
		pl:EmitSound("ricochet/scream"..math.random(1,3)..".wav")
	end

	if attacker ~= pl and attacker:IsPlayer() then 
		attacker:AddFrags(1)
		if attacker:Frags() >= DEATHMATCH_FRAGLIMIT and not GetGlobalBool("rc_roundend") then
			SetGlobalBool("rc_roundend", true)
			for _, v in pairs(player.GetAll()) do
				v:ChatPrint("The Round is over! The winner is: "..tostring(attacker:Nick()).."! Round "..tostring(GetGlobalInt("rc_round")).." starts in 10 seconds!")
			end
			timer.Create("RestartRound", 10, 1, function() self:RestartGame() end)
		end
	end
end

function GM:PlayerDeathSound()
	return true
end

function GM:PlayerNoClip(pl)
	return true
end