util.PrecacheSound("ricochet/decap.wav")

function EFFECT:Init(data)
	self.Owner = data:GetEntity()
	self:SetRenderBounds(Vector(-128,-128,-128), Vector(128, 128, 128))
	self.BleedoutTime = CurTime()+4
	self.Head = true
	self.Owner:GetRagdollEntity():EmitSound("ricochet/decap.wav")
end

function EFFECT:Think()
	local ent = self.Owner
	
	ent = ent:GetRagdollEntity()
	if self.Owner:Health() > 0 or self.Owner:Alive() then return false end
	if not ent then return false end
	local boneid = ent:LookupBone("ValveBiped.Bip01_Head1")

	if boneid and boneid > 0 then
		ent:ManipulateBoneScale(boneid, Vector(0.01,0.01,0.01))
	end
	
	local BonePos , BoneAng = ent:GetBonePosition(boneid)
	local emitter = ParticleEmitter(BonePos)
	if self.Head then
		for i=14, 18 do
			local particle = emitter:Add("noxctf/sprite_bloodspray"..math.random(8), BonePos)
			particle:SetLighting(true)
			particle:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*55)
			particle:SetDieTime(3)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(255)
			particle:SetStartSize(math.Rand(8,9))
			particle:SetGravity(Vector(0, 0, -200))
			particle:SetEndSize(1.5)
			particle:SetRoll(math.Rand(-25, 25))
			particle:SetRollDelta(math.Rand(-25, 25))
			particle:SetAirResistance(5)
			particle:SetCollide(true)
			particle:SetColor(255, 0, 0)
		end
		self.Head = false
	end
	for i=1, 2 do
		local particle = emitter:Add("noxctf/sprite_bloodspray"..math.random(8), BonePos)
		particle:SetLighting(true)
		particle:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*16)
		particle:SetDieTime(3)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(255)
		particle:SetStartSize(math.Rand(1.5, 2.5))
		particle:SetEndSize(1.5)
		particle:SetRoll(math.Rand(-25, 25))
		particle:SetRollDelta(math.Rand(-25, 25))
		particle:SetAirResistance(5)
		particle:SetGravity(Vector(0, 0, -600))
		particle:SetCollide(true)
		particle:SetColor(255, 0, 0)
	end
	
	emitter:Finish()
	if self.BleedoutTime < CurTime() then
		return false
	end
	return true
end

function EFFECT:Render()
end
