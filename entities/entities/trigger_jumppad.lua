ENT.Type = "brush"

AccessorFunc(ENT, "m_OverrideVelocity", "OverrideVelocity", FORCE_BOOL)
AccessorFunc(ENT, "m_PushVelocity", "PushVelocity")

function ENT:Initialize()
	if self:GetPushVelocity() == nil then self:SetPushVelocity(0) end
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if key == "overridevelocity" then
		self:SetOverrideVelocity((tonumber(value) or 0) == 1)
	elseif key == "pushvelocity" then
		self:SetPushVelocity(tonumber(value) or Vector(value or "") or 0)
	end
end

function ENT:AcceptInput(name, activator, caller, args)
end

function ENT:StartTouch(ent)
	self:Push(ent)
end

function ENT:Push(ent)
	if not IsValid(ent) or not ent:IsPlayer() then return end

	local vel = self:GetPushVelocity()
	if self:GetOverrideVelocity() then
		ent:SetLocalVelocity(vel)
	else
		ent:SetVelocity(vel)
	end

	self:EmitSound("ricochet/triggerjump.wav")
end
