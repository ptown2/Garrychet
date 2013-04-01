function EFFECT:Init(data)
	local normal = data:GetNormal() * -1

	local ang = normal:Angle()
	
	local pos = data:GetOrigin()

	local alt
	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(24, 32)
	local sep = 3
	for i=1, 20 do
		alt = not alt
		if alt then
			local particle = emitter:Add("noxctf/sprite_smoke", pos + Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1)) * 32)
			particle:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*50)
			particle:SetDieTime(math.Rand(1, 1.2))
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(255)
			particle:SetStartSize(math.Rand(50, 72))
			particle:SetEndSize(0)
			particle:SetColor(50, 39, 15)
			particle:SetRoll(math.Rand(0, 359))
			particle:SetRollDelta(math.Rand(-2, 2))
			particle:SetAirResistance(math.Rand(10, 22))
			particle:SetBounce(0.4)
		else
			local particle = emitter:Add("effects/fire_cloud1", pos + Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1)) * 18)
			particle:SetVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1))*75)
			particle:SetDieTime(1)
			particle:SetStartAlpha(220)
			particle:SetEndAlpha(0)
			particle:SetStartSize(32)
			particle:SetEndSize(4)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetAirResistance(12)
			particle:SetBounce(0.4)
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
