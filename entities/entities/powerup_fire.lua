AddCSLuaFile()

ENT.Type = "anim"

function ENT:Initialize()
	self:SetModel("models/ricochet/ricochet_disc.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetColor(COLOR_RED)

	if SERVER then
		self:SetTrigger(true)
		self:SetNotSolid(true)
	end

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:EnableMotion(false)
		phys:Wake()
	end
end

if SERVER then	
	function ENT:StartTouch(activator)
		if activator:IsPlayer() then
			activator:SetPowerup(POWERUP_FIRE, 3)
			self:EmitSound("ricochet/powerup.wav")
			self:Remove()
		end
	end
	
	function ENT:OnRemove()
		self.Owner.LastPowerup = CurTime()
	end
end

if CLIENT then
	function ENT:Initialize()
		self.Emitter = ParticleEmitter(self:GetPos())
		self.Emitter:SetNearClip(24, 32)
		self:DrawShadow(false)
	end
	
	function ENT:Think()
		self:SetAngles(Angle(math.sin(CurTime()) * 100, math.cos(CurTime()) * 100, 0))
	end
	
	function ENT:DrawFire()
		local vOffset = self:GetPos() + Vector(math.sin(CurTime()*3)*15, math.cos(CurTime()*3)*15,math.cos(CurTime()*5)*20)
		local vOffset2 = self:GetPos() + Vector(math.cos(CurTime()*3)*15, math.sin(CurTime()*3)*15,math.sin(CurTime()*5)*20)

		local emitter = self.Emitter
		emitter:SetPos(vOffset)
		local particle = emitter:Add("effects/fire_cloud1", vOffset)
		particle:SetDieTime(0.2)
		particle:SetStartAlpha(150)
		particle:SetEndAlpha(60)
		particle:SetStartSize(math.Rand(4, 6))
		particle:SetEndSize(2)
		particle:SetRoll(math.Rand(0, 359))
		particle:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*20)

		emitter:SetPos(vOffset2)
		local particle = emitter:Add("effects/fire_cloud1", vOffset2)
		particle:SetDieTime(0.2)
		particle:SetStartAlpha(150)
		particle:SetEndAlpha(60)
		particle:SetStartSize(math.Rand(4, 6))
		particle:SetEndSize(2)
		particle:SetRoll(math.Rand(0, 359))
		particle:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*20)

		local pos3 = self:GetPos()
		local emitter = self.Emitter
		emitter:SetPos(pos3)
		local particle = emitter:Add("effects/fire_cloud1", pos3)
		particle:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*50)
		particle:SetDieTime(0.2)
		particle:SetStartAlpha(150)
		particle:SetEndAlpha(60)
		particle:SetStartSize(math.Rand(2, 4))
		particle:SetEndSize(6)
		particle:SetRoll(math.Rand(0, 359))
	end
	
	function ENT:Draw()
		self:DrawModel()
		self:DrawFire()
	end
end