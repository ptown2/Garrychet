AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.Bounces = 5
ENT.DeathLimit = 20

function ENT:Initialize()
	self:SetModel("models/ricochet/ricochet_disc.mdl")
	self:PhysicsInitSphere(6)
	self:SetMoveType(MOVETYPE_VPHYSICS)

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
end

function ENT:Launch(speed)
	local owner = self:GetOwner()
	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:SetVelocityInstantaneous(self:GetForward() * speed)
		self.Direction = self:GetForward()
	end

	local tracedata = {}
	tracedata.start = owner:GetPos() + Vector(0,0,36)
	tracedata.endpos = tracedata.start + self:GetForward()*64
	tracedata.filter = {self,owner}
	tracedata.mins = self:OBBMins()
	tracedata.maxs = self:OBBMaxs()

	local trace = util.TraceHull(tracedata)
	if trace.Hit then
		local hitent = trace.Entity

		if hitent then
			if hitent:IsValid() and hitent:IsPlayer() and hitent ~= self:GetOwner() and (hitent:Team() ~= self:GetOwner():Team() or GetGlobalInt("GameType") == 1) then
				hitent:SetLastAttacker(self:GetOwner())
				if self:GetPowerup() == POWERUP_FREEZE then
					hitent:SetStatus(POWERUP_FREEZE, CurTime()+1)
					hitent:SetWalkSpeed(15)
					hitent:SetRunSpeed(15)
					hitent:SetMaxSpeed(15)
					hitent:SetMaterial("models/shiny")
				end
				hitent:SetVelocity(self.Direction * 1000)
			end
			if self:GetPowerup() == POWERUP_FIRE then
				for k,v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
					if v:IsPlayer() then
						v:SetVelocity((v:GetPos() - self:GetPos()):GetNormal() * 1000 + Vector(0, 0, 20))
					end
				end
			end
			if self:GetPowerup() == POWERUP_FREEZE then
				self:EmitSound("physics/glass/glass_sheet_break"..math.random(1, 3)..".wav")
			else
				self:EmitSound("ricochet/disc_hit"..math.random(1,2)..".wav", 78, 80)
			end
			self:Remove()
			return
		end
	end
end

function ENT:Think()
	local data = self.HitData
	if data then
		local hitent = data.HitEntity
		self.HitData = nil
		if hitent then
			if hitent:IsValid() and hitent:IsPlayer() and hitent ~= self:GetOwner() and (hitent:Team() ~= self:GetOwner():Team() or GetGlobalInt("GameType") == 1) then
				hitent:SetLastAttacker(self:GetOwner())
				if self:GetPowerup() == POWERUP_FREEZE then
					hitent:SetStatus(POWERUP_FREEZE, CurTime() + 2)
					hitent:SetWalkSpeed(15)
					hitent:SetRunSpeed(15)
					hitent:SetMaxSpeed(15)
					hitent:SetMaterial("models/shiny")
				end
				hitent:SetVelocity(self.Direction * 1000)
			end

			if self:GetPowerup() == POWERUP_FIRE then
				for _, v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
					if v:IsPlayer() then
						v:SetVelocity((v:GetPos() - self:GetPos()):GetNormal() * 1000 + Vector(0, 0, 20))
					end
				end
			end
			if self:GetPowerup() == POWERUP_FREEZE then
				self:EmitSound("physics/glass/glass_sheet_break"..math.random(1, 3)..".wav")
			else
				self:EmitSound("ricochet/disc_hit"..math.random(1,2)..".wav", 78, 80)
			end

			self:Remove()
			return
		end
	end

	if not self.DeathTime or CurTime() < self.DeathTime then return end

	self.DeathTime = 0
	self:Remove()
end

function ENT:PhysicsCollide(data, phys)
	self.HitData = data
	self:NextThink(CurTime())
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	
	if owner:Alive() and owner:GetActiveWeapon():Clip1() < 3 then
		owner:GetActiveWeapon():SetClip1(owner:GetActiveWeapon():Clip1() + self:GetAmmoBack()) 
	end

	if self:GetPowerup() then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:LocalToWorld(self:OBBCenter()))

		if self:GetPowerup() == POWERUP_FREEZE then
			util.Effect("icedisc_explosion", effectdata)
		elseif self:GetPowerup() == POWERUP_FIRE then
			util.Effect("firedisc_explosion", effectdata)
		end
	else
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
end
