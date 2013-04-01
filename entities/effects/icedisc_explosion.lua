function EFFECT:Init(data)
	local normal = data:GetNormal() * -1

	local ang = normal:Angle()
	
	local pos = data:GetOrigin()

	local alt
	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(24, 32)
	local sep = 3
	for i=1, 10 do
		local particle = emitter:Add("particle/snow", pos + Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1)) * 18)
		particle:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*75)
		particle:SetDieTime(1)
		particle:SetStartAlpha(220)
		particle:SetEndAlpha(0)
		particle:SetStartSize(18)
		particle:SetEndSize(4)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetAirResistance(12)
		particle:SetBounce(0.4)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
