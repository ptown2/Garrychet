ENT.Type = "anim"

function ENT:SetAmmoBack(amt)
	self:SetDTInt(0, amt)
end

function ENT:GetAmmoBack()
	return self:GetDTInt(0)
end

function ENT:SetPowerShot(bool)
	self:SetDTBool(0, bool)
end

function ENT:GetPowerShot()
	return self:GetDTBool(0)
end