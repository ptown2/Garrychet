--[[
	Garrychet (aka. Ricochet 2)
	Made by: Nightmare
	Continued by: ptown2
	
	A gmod13 redo of the Ricochet game

TODO:
	- Setup multi-powerups IE get power disc and then get ice disc
]]

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")

AddCSLuaFile("shared.lua")
AddCSLuaFile("sh_global.lua")
AddCSLuaFile("sh_colors.lua")

AddCSLuaFile("obj_entity_extend.lua")
AddCSLuaFile("obj_player_extend.lua")
AddCSLuaFile("obj_weapon_extend.lua")
AddCSLuaFile("obj_server_extend.lua")

include("shared.lua")

include("obj_player_extend.lua")
include("obj_player_extend_sv.lua")
include("obj_entity_extend.lua")
include("obj_weapon_extend.lua")

GM:LoadGametypes()

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

	resource.AddFile("materials/noxctf/sprite_bloodspray1.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray2.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray3.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray4.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray5.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray6.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray7.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray8.vmt")
	
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
	
end

function GM:Initialize()
	self:AddResources()
	self:PrecacheResources()
	self:SetGlobalVars()
end

function GM:Think()
	if CurTime() >= TIMELIMIT then
		local state = self:GetGamestate()

		if state == STATE_WAITING or state == STATE_ENDING then
			self:RestartGame()
		end
	end

	ValidFunction(GAMETYPES[self:GetGametype()], "OnThink")
end

function GM:PlayerInitialSpawn(pl)
	local rawmodelname = pl:GetInfo("cl_playermodel")
	local modelname = player_manager.TranslatePlayerModel(rawmodelname)
	pl:SetModel(modelname)

	ValidFunction(GAMETYPES[self:GetGametype()], "OnPlayerInitSpawn", pl)
end

function GM:PlayerSpawn(pl)
	pl:SetWalkSpeed(150)
	pl:SetRunSpeed(150)
	pl:SetMaxSpeed(150)
	pl:SetJumpPower(0)
	pl:SetMaterial()
	pl:SetLastAttacker(nil)
	self:PlayerLoadout(pl)

	local effectdata = EffectData()
		effectdata:SetOrigin(pl:GetPos())
	util.Effect("spawneffect", effectdata, true)

	ValidFunction(GAMETYPES[self:GetGametype()], "OnPlayerSpawn", pl)
end

function GM:PlayerLoadout(pl)
	pl:Give("weapon_disc")

	ValidFunction(GAMETYPES[self:GetGametype()], "OnLoadout", pl)
end

function GM:EntityTakeDamage(pl, dmginfo)
	if dmginfo:GetAttacker() ~= pl and pl:GetLastAttacker():IsPlayer() and (pl:GetLastAttackerTime() + 3) > CurTime() then
		dmginfo:SetAttacker(pl:GetLastAttacker())
	end
end

function GM:DoPlayerDeath(pl, attacker, dmginfo)
	pl:CreateRagdoll()
	pl:AddDeaths(1)
	pl:RemoveStatus("freeze", true, true)

	local dmgtype = dmginfo:GetDamageType()
	if dmgtype == POWERUP_FIRE then
		local effectdata = EffectData()
			effectdata:SetOrigin(pl:LocalToWorld(pl:OBBCenter()))
			effectdata:SetEntity(pl)
		util.Effect("fire_death", effectdata, true)
	elseif dmgtype == POWERUP_FREEZE then
		local effectdata = EffectData()
			effectdata:SetOrigin(pl:LocalToWorld(pl:OBBCenter()))
			effectdata:SetEntity(pl)
		util.Effect("ice_death", effectdata, true)
	end

	if attacker:IsValid() and attacker:IsPlayer() and (dmginfo:GetInflictor():GetClass() == "projectile_disc" and (dmginfo:GetInflictor():GetPowerShot() or false)) then
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
	end

	ValidFunction(GAMETYPES[self:GetGametype()], "OnPlayerDeath", pl, attacker)
	hook.Call("OnPlayerDeath", pl, attacker)
end

function GM:GetFallDamage(pl, speed)
	return false
end

function GM:PlayerDeathSound()
	return true
end

function GM:PlayerNoClip(pl)
	return true
end

--[[hook.Add("OnPlayerDeath", "CheckIfCall", function(...)
	MsgN(...)
end)]]
