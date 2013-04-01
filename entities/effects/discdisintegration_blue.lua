function EFFECT:Init(data)
	local pos = data:GetOrigin()
	
	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(24, 32)
	for i=1, math.Rand(12, 14) do
		local particle = emitter:Add("sprites/glow04_noz", pos+Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-0.5,0.5))*2)
		particle:SetDieTime(1)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(30)
		particle:SetStartSize(12)
		particle:SetEndSize(4)
		particle:SetColor(50,150,255)
		particle:SetRoll(math.random(0, 360))
		particle:SetCollide(true)
		particle:SetBounce(0.4)
		particle:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-0.5,0.5))*3)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
