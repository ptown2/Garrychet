MySelf = MySelf or NULL
hook.Add("InitPostEntity", "GetLocal", function()
	MySelf = LocalPlayer()
end)

include("shared.lua")
include("sh_colors.lua")
include("cl_hud.lua")
include("obj_player_extend.lua")

local ColorModDead = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 1,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

function GM:CreateFonts()
	--surface.CreateFont({})
end

function GM:Initialize()
	self:CreateFonts()
end

function GM:CalcView(pl, origin, angles, fov)
	if not IsValid(pl) then return end

	if not pl:Alive() then
		local ragdoll = pl:GetRagdollEntity()
		if IsValid(ragdoll) then
			local ent = ragdoll:GetAttachment(pl:GetRagdollEntity():LookupAttachment("eyes"))
			origin = ent.Pos
			angles = ent.Ang
		end
	end
		
	return self.BaseClass.CalcView(self, pl, origin, angles, fov)
end

function GM:PlayerBindPress(pl, bind, on)
	if (bind == "+jump" or bind == "+duck") then
		return true
	end
end

function GM:RenderScreenspaceEffects()
	if not IsValid(MySelf) then return end

	if not MySelf:Alive() and not MySelf.DeathTime then
		MySelf.DeathTime = CurTime()
	elseif MySelf:Alive() and MySelf.DeathTime then
		MySelf.DeathTime = nil
	end

	if not MySelf:Alive() then
		local contrasteffect = 1 - math.min(CurTime() - MySelf.DeathTime, 1)
		ColorModDead["$pp_colour_contrast"] = contrasteffect
		DrawColorModify(ColorModDead)
	end
end