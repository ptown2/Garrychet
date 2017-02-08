AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.MaxBounces = 3 -- Works fine on latest beta map (Except loss in velocity)
ENT.DeathLimit = 15

function ENT:Initialize()
	self:SetModel("models/disc.mdl")
	self:PhysicsInitSphere(6)
	self:SetMoveType(MOVETYPE_VPHYSICS) --MOVETYPE_VPHYSICS

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:SetBuoyancyRatio(0)
		phys:Wake()
	end

	self:EmitSound("ricochet/disc_fire.wav")

	self.DeathTime = self.DeathTime or CurTime() + self.DeathLimit 
	self.Direction = Vector(0, 0, 0)
	self.Bounces = 0
end

function ENT:Launch(speed)
	local owner = self:GetOwner()
	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:SetVelocityInstantaneous(self:GetForward() * speed)
		self.Direction = self:GetForward()
	end
end

function ENT:Touch(hitent)
	local owner = self:GetOwner()

	if IsValid(hitent) and hitent:IsPlayer() and not (hitent == owner) and (not (hitent:Team() == owner:Team()) or (GetGlobalString("rc_gametype") == "dm")) then
		hitent:SetLastAttacker(self:GetOwner())
		if self:GetPowerShot() then hitent:TakeDamage(999, self:GetOwner(), self) end
		hitent:SetVelocity(self.Direction * 1000)
	end

	self:EmitSound("ricochet/disc_hit"..math.random(1,2)..".wav", 78, 80)
	self:Remove()
end

function ENT:Think()
	if self.DeathTime and CurTime() >= self.DeathTime then
		self:Remove()
	end
end

function ENT:PhysicsCollide(data, physobj)
	local vphys = physobj:GetVelocity() * data.OurOldVelocity:Length()
	local angles = self:GetAngles()

	physobj:SetVelocityInstantaneous(Vector(vphys.x / 1000, vphys.y / 1000, 0))

	self:EmitSound("ricochet/disc_hit"..math.random(1,2)..".wav", 78, 80)
	self.Direction = self:GetForward()
	self.Bounces = self.Bounces + 1
		if self.MaxBounces <= self.Bounces then --Is there away to remove this if it goes outside the map (Hits edge), versus ingame walls. It bounces off the edge of map
		timer.Simple(0, function() --Remove the next frame..
			if (IsValid(self)) then
				self:Remove()
			end
		end)
	end
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	
	if owner:Alive() and owner:GetActiveWeapon():Clip1() < 3 then
		owner:GetActiveWeapon():SetClip1(owner:GetActiveWeapon():Clip1() + self:GetAmmoBack()) 
	end

	local effectdata = EffectData()
	effectdata:SetOrigin(self:LocalToWorld(self:OBBCenter()))

	if owner:Team() == TEAM_BLUE then
		util.Effect("discdisintegration_blue", effectdata)
	elseif owner:Team() == TEAM_RED or owner:Team() == TEAM_DEATHMATCH then
		util.Effect("discdisintegration_red", effectdata)
	else
		util.Effect("discdisintegration_gray", effectdata)	
	end
end
