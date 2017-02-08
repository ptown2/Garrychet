AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/powerup.mdl") 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetColor(self.Color)
	self:SetTrigger(true)
	self:SetNotSolid(true)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:EnableMotion(false)
		phys:Wake()
	end
end

function ENT:StartTouch(activator)
	if not IsValid(activator) then return end

	if activator:IsPlayer() then
		MsgN(self.Powerup)
		activator:GiveStatus(self.Powerup, -1)
		self:EmitSound("ricochet/powerup.wav")
		self:Remove()
	end
end

function ENT:OnRemove()
	self.Owner.LastPowerup = CurTime()
end
