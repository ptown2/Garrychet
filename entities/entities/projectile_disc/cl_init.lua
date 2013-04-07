include("shared.lua")

local matGlow = Material("sprites/glow04_noz")

function ENT:DrawFreeze()
	local vOffset = self:GetPos() + Vector(math.cos(CurTime() * 15) * 10, math.sin(CurTime() * 15) * 10, 0)

	local emitter = self.Emitter
	emitter:SetPos(vOffset)
	local particle = emitter:Add("particle/snow", vOffset)
	particle:SetDieTime(0.3)
	particle:SetStartAlpha(150)
	particle:SetEndAlpha(60)
	particle:SetStartSize(math.Rand(4, 6))
	particle:SetEndSize(2)
	particle:SetRoll(math.Rand(0, 359))
	particle:SetVelocity(Vector(math.Rand(-1, 1),math.Rand(-1, 1),math.Rand(-1, 1)) * 20)
end

function ENT:DrawFire()
	local vOffset = self:GetPos() + Vector(math.cos(CurTime()*25)*10,math.sin(CurTime()*25)*10,0)

	local emitter = self.Emitter
	emitter:SetPos(vOffset)
	local particle = emitter:Add("sprites/glow04_noz", vOffset)
	particle:SetDieTime(0.5)
	particle:SetStartAlpha(150)
	particle:SetEndAlpha(60)
	particle:SetStartSize(math.Rand(7, 10))
	particle:SetEndSize(2)
	particle:SetRoll(math.Rand(0, 359))
	particle:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*20)
	particle:SetColor(255,150,0)
end

function ENT:DrawFast()
	local vOffset = self:GetPos() + Vector(math.cos(CurTime()*25)*10,math.sin(CurTime()*25)*10,0) + self:GetForward()*25

	local emitter = self.Emitter
	emitter:SetPos(vOffset)
	local col = self:GetColor()
	local particle = emitter:Add("sprites/glow04_noz", vOffset)
	particle:SetDieTime(0.5)
	particle:SetStartAlpha(150)
	particle:SetEndAlpha(60)
	particle:SetStartSize(math.Rand(7, 10))
	particle:SetEndSize(2)
	particle:SetRoll(math.Rand(0, 359))
	particle:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*20)
	particle:SetColor(col.r,col.g,col.b)
end

function ENT:DrawPower()
	local vOffset = self:GetPos() + self:GetForward() * 5

	local emitter = self.Emitter
	emitter:SetPos(vOffset)
	local particle = emitter:Add("sprites/glow04_noz", vOffset)
	local col = self:GetColor()
	particle:SetColor(col.r,col.g,col.b)
	particle:SetDieTime(0.3)
	particle:SetStartAlpha(150)
	particle:SetEndAlpha(60)
	particle:SetStartSize(8)
	particle:SetEndSize(4)
	particle:SetRoll(math.Rand(0, 359))

	for i=1, 3 do
		local particle = emitter:Add("sprites/glow04_noz", vOffset)
		local col = self:GetColor()
		particle:SetColor(col.r,col.g,col.b)
		particle:SetVelocity(self:GetRight() * (i-2) * 40)
		particle:SetDieTime(0.3)
		particle:SetStartAlpha(150)
		particle:SetEndAlpha(60)
		particle:SetStartSize(8)
		particle:SetEndSize(4)
		particle:SetRoll(math.Rand(0, 359))
	end
end

function ENT:DrawTrail()
	local vOffset = self:GetPos() + Vector(math.sin(CurTime()*25)*10,math.cos(CurTime()*25)*10,0)

	local emitter = self.Emitter
	local col = self:GetColor()
	emitter:SetPos(vOffset)
	local particle = emitter:Add("sprites/glow04_noz", vOffset)
	particle:SetDieTime(0.5)
	particle:SetStartAlpha(150)
	particle:SetEndAlpha(60)
	particle:SetStartSize(math.Rand(7, 10))
	particle:SetEndSize(2)
	particle:SetRoll(math.Rand(0, 359))
	particle:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*20)
	particle:SetColor(col.r,col.g,col.b)
end

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self:GetPos())
	self.Emitter:SetNearClip(24, 32)
	self:DrawShadow(false)
	self:SetMaterial("models/debug/shiny")
end

function ENT:Draw()
	self:DrawModel()

	if self:GetPowerShot() then self:DrawPower() else self:DrawTrail() end

	local col = self:GetColor()
	render.SetMaterial(matGlow)
	render.DrawSprite(self:GetPos(), 32, 32, col)
end

function ENT:Think()
	local dlight = DynamicLight(self:EntIndex())
	if dlight then
		local c = self:GetColor()
		dlight.Pos = self:GetPos() - Vector(0,0,5)
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = 5
		dlight.Decay = 256
		dlight.Size = 128
		dlight.DieTime = CurTime() + 1
	end
end
