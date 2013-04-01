AddCSLuaFile()

ENT.Type = "anim"

function ENT:Initialize()
	self:SetModel("models/ricochet/ricochet_disc.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:SetMoveType(MOVETYPE_NONE)
	if SERVER then
		self:SetTrigger( true )
		self:SetNotSolid( true )
	end
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:EnableMotion(false)
		phys:Wake()
	end
	self:SetColor(Color(255,0,0,255))
end

if SERVER then
	function ENT:Think()
		self:SetAngles(Angle(0,math.cos(CurTime())*100,0))
	end
	
	function ENT:Touch(activator)
		if activator:IsPlayer() then
			self:EmitSound("ricochet/powerup.wav")
			activator:SetPowerup(POWERUP_POWERSHOT, 3)
			activator:GetActiveWeapon():ResetFireSpeed()
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
	
	function ENT:DrawEffect()
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
		particle:SetColor(255,0,0)
	end
	
	function ENT:Draw()
--		self:DrawModel()
		self:DrawEffect()
	end
end