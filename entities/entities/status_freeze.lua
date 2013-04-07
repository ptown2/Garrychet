AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status__base"

if SERVER then
	function ENT:PlayerSet(pPlayer, bExists)
		pPlayer:SetWalkSpeed(DEFAULT_PL_FREEZE_SPEED)
		pPlayer:SetRunSpeed(DEFAULT_PL_FREEZE_SPEED)
		pPlayer:SetMaxSpeed(DEFAULT_PL_FREEZE_SPEED)
		pPlayer:SetMaterial("models/shiny")
	end

	function ENT:OnRemove()
		local parent = self:GetOwner()
		if IsValid(parent) then
			if not self.SilentRemove then end
			parent:SetWalkSpeed(DEFAULT_PL_SPEED)
			parent:SetRunSpeed(DEFAULT_PL_SPEED)
			parent:SetMaxSpeed(DEFAULT_PL_SPEED)
			parent:SetMaterial()
		end
	end
end

if CLIENT then
	function ENT:Initialize()
		self:DrawShadow(false)
		self:SetRenderBounds(Vector(-40, -40, -18), Vector(40, 40, 48))

		local owner = self:GetOwner()
		if owner:IsValid() then
			owner[self:GetClass()] = self
			self.DieTime = self:GetDTInt(0)
		end

		self.Emitter = ParticleEmitter(self:GetPos())
		self.Emitter:SetNearClip(28, 32)
	end

	function ENT:OnRemove()
		self.Emitter:Finish()
	end

	function ENT:Think()
		self.Emitter:SetPos(self:GetPos())
	end

	function ENT:Draw()
		local owner = self:GetOwner()
		if not owner:IsValid() then return end

		local pos = owner:GetPos() + Vector(0, 0, 16)
		local emitter = self.Emitter
		for i=1, 2 do
			local particle = emitter:Add("particle/smokestack", pos + VectorRand() * 12)
			particle:SetVelocity(Vector(0, 0, 30))
			particle:SetDieTime(0.5)
			particle:SetStartAlpha(64)
			particle:SetEndAlpha(200)
			particle:SetStartSize(6)
			particle:SetEndSize(4)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-10, 10))
			particle:SetColor(255, 255, 255)
			particle:SetGravity(Vector(0,0,-500))

			particle = emitter:Add("sprites/light_glow02_add", pos + VectorRand() * 12)
			particle:SetVelocity(Vector(0, 0, 30))
			particle:SetDieTime(0.5)
			particle:SetStartAlpha(64)
			particle:SetEndAlpha(200)
			particle:SetStartSize(2)
			particle:SetEndSize(8)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-10, 10))
			particle:SetColor(255, 255, 255)
			particle:SetGravity(Vector(0, 0, -500))
		end
	end
end