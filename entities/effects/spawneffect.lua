function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local emitter = ParticleEmitter(pos)

	for i=1, 360, 16 do
		local particle = emitter:Add("sprites/glow04_noz", pos + Vector(8 * math.cos(i), 8 * math.sin(i), 0))
		particle:SetVelocity(Vector(4 * math.cos(i), 4 * math.sin(i), 0))
		particle:SetDieTime(1)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(32)
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-16, 16))
		particle:SetColor(255, 255, 255)
	end

	for i=1, 360, 16 do
		local particle = emitter:Add("sprites/glow04_noz", pos + Vector(8 * math.cos(i), 8 * math.sin(i), 16))
		particle:SetVelocity(Vector(8 * math.cos(i), 8 * math.sin(i), 0))
		particle:SetDieTime(1)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(32)
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-16, 16))
		particle:SetColor(255, 255, 255)
	end

	self:EmitSound("ricochet/pspawn.wav")
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
