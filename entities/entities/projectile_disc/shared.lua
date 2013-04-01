ENT.Type = "anim"

function ENT:SetPowerup(index)
	self:SetDTInt(0, index)
end

function ENT:GetPowerup(index)
	return self:GetDTInt(0)
end

function ENT:SetAmmoBack(amt)
	self:SetDTInt(1, amt)
end

function ENT:GetAmmoBack()
	return self:GetDTInt(1)
end
