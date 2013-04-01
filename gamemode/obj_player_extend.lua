local meta = FindMetaTable("Player")
if not meta then return end

if SERVER then
	function meta:SetPowerup(powerup, amount)
		self:SetDTInt(0, powerup or POWERUP_NONE)
		self:SetDTInt(1, amount or 0)
	end
	
	function meta:ReducePowerupAmmo(ammo)
		ammo = ammo or 1
		self:SetDTInt(1, self:GetPowerupAmmo() - ammo)
	end
	
	function meta:SetLastAttacker(ent)
		self:SetDTEntity(0, ent)
		self:SetDTFloat(1, CurTime())
	end
	
	function meta:SetStatus(index, time)
		self:SetDTInt(2, index or 0)
		self:SetDTFloat(2, time or 0)
	end
	
	function meta:SetAlive(bool)
		self:SetDTBool(0, bool)
	end
end

function meta:Alive()
	return self:GetDTBool(0)
end

function meta:GetStatus()
	return self:GetDTInt(2), self:GetDTFloat(2)
end

function meta:GetPowerup()
	return self:GetDTInt(0)
end

function meta:GetPowerupAmmo()
	return self:GetDTInt(1)
end

function meta:GetLastAttackerTime()
	return self:GetDTFloat(1)
end

function meta:GetLastAttacker()
	return self:GetDTEntity(0)
end

