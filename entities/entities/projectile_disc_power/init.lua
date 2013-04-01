AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
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

	self:EmitSound("ricochet/disc_fire.wav",120,85)

	self.DeathTime = self.DeathTime or CurTime() + 5
	self.Direction = Vector(0,0,0)
end

function ENT:Launch(speed)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		self.Direction = self:GetForward()
	end
	--[[local tracedata = {}
	tracedata.start = self:GetOwner():GetPos() + Vector(0,0,36)
	tracedata.endpos = tracedata.start + self:GetForward()*64
	tracedata.filter = {self,self:GetOwner()}
	tracedata.mins = self:OBBMins()
	tracedata.maxs = self:OBBMaxs()
	local trace = util.TraceHull(tracedata)
	
	if trace.Hit then
		local hitent = trace.Entity
		if hitent then
			if hitent:IsValid() and hitent:IsPlayer() and hitent ~= self:GetOwner() and (hitent:Team() ~= self:GetOwner():Team() or GetGlobalInt("GameType") == 1) then
				hitent:SetVelocity(self:GetForward() * 1000)
				hitent:SetLastAttacker(self:GetOwner())
				if self:GetPowerup() ~= 0 then
					hitent:TakeSpecialDamage(100, self:GetPowerup(), self:GetOwner(), self)
				else
					hitent:TakeDamage(100, self:GetOwner(), self)
				end
			end
			if self:GetPowerup() == POWERUP_FIRE then
				for k,v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
					if v:IsPlayer() then
						v:SetVelocity((v:GetPos()-self:GetPos()+Vector(0,0,20)):GetNormal()*1000)
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
	end]]
	
	if phys:IsValid() then
		phys:SetVelocityInstantaneous(self:GetForward() * speed)
	end
end

function ENT:Think()
	local data = self.HitData

	if self.DeathTime and CurTime() > self.DeathTime then 
		self:Remove()
		return
	end

	if data then
		self.HitData = nil
		
		local hitent = data.HitEntity
		if hitent then
			if hitent:IsValid() and hitent:IsPlayer() and hitent ~= self:GetOwner() and (hitent:Team() ~= self:GetOwner():Team() or GetGlobalInt("GameType") == 1) then
				hitent:SetVelocity(self:GetForward()*1000)
				hitent:SetLastAttacker(self:GetOwner())
				if self:GetPowerup() ~= 0 then
					hitent:TakeSpecialDamage(100, self:GetPowerup(), self:GetOwner(), self)
				else
					hitent:TakeDamage(100, self:GetOwner(), self)
				end
			end
			if self:GetPowerup() == POWERUP_FIRE then
				for _, v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
					if v:IsPlayer() then
						v:SetVelocity((v:GetPos()-self:GetPos()):GetNormal()*1000)
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

function ENT:PhysicsCollide(data, phys)
	self.HitData = data

	self:NextThink(CurTime())
end

function ENT:OnRemove()
	if (self:GetPowerup() ~= 0 or nil) and self:GetPowerup() ~= POWERUP_POWERSHOT then
		if self:GetPowerup() == POWERUP_FREEZE then
			local effectdata = EffectData()
				effectdata:SetOrigin(self:GetPos())
			util.Effect("icedisc_explosion", effectdata)
		elseif self:GetPowerup() == POWERUP_FIRE then
			local effectdata = EffectData()
				effectdata:SetOrigin(self:GetPos())
			util.Effect("firedisc_explosion", effectdata)
		end
	else
		if self:GetOwner():Team() == TEAM_BLUE then
			local effectdata = EffectData()
				effectdata:SetOrigin(self:GetPos())
			util.Effect("discdisintegration_blue", effectdata)
		elseif self:GetOwner():Team() == TEAM_RED or self:GetOwner():Team() == TEAM_DEATHMATCH then
			local effectdata = EffectData()
				effectdata:SetOrigin(self:GetPos())
			util.Effect("discdisintegration_red", effectdata)
		else
			local effectdata = EffectData()
				effectdata:SetOrigin(self:GetPos())
			util.Effect("discdisintegration_gray", effectdata)	
		end
	end
	if self:GetOwner():Health() > 0 and self:GetOwner():GetActiveWeapon():Clip1() < 3 then self:GetOwner():GetActiveWeapon():SetClip1(self:GetOwner():GetActiveWeapon():Clip1()+self:GetAmmoBack()) end
end
