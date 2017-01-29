local meta = FindMetaTable("Player")
if not meta then return end

--[[function meta:SetPowerup(powerup, amount)
	self:SetDTInt(0, powerup or POWERUP_NONE)
	self:SetDTInt(1, amount or 0)
end

function meta:ReducePowerupAmmo(ammo)
	ammo = ammo or 1
	self:SetDTInt(1, self:GetPowerupAmmo() - ammo)
end]]

function meta:SetLastAttacker(ent)
	self:SetDTEntity(0, ent)
	self:SetDTFloat(0, CurTime())
end

function meta:RemoveAllStatus(bSilent, bInstant)
	if bInstant then
		for _, ent in pairs(ents.FindByClass("status_*")) do
			if not ent.NoRemoveOnDeath and ent:GetOwner() == self then
				ent:Remove()
			end
		end
	else
		for _, ent in pairs(ents.FindByClass("status_*")) do
			if not ent.NoRemoveOnDeath and ent:GetOwner() == self then
				ent.SilentRemove = bSilent
				ent:SetDie()
			end
		end
	end
end

function meta:RemoveStatus(sType, bSilent, bInstant, sExclude)
	local removed

	for _, ent in pairs(ents.FindByClass("status_"..sType)) do
		if ent:GetOwner() == self and not (sExclude and ent:GetClass() == "status_"..sExclude) then
			if bInstant then
				ent:Remove()
			else
				ent.SilentRemove = bSilent
				ent:SetDie()
			end
			removed = true
		end
	end

	return removed
end

function meta:GetStatus(sType)
	local ent = self["status_"..sType]
	if ent and ent:IsValid() and ent.Owner == self then
		return ent
	else
		return false
	end
end

function meta:GiveStatus(sType, fDie)
	local cur = self:GetStatus(sType)
	if cur then
		if fDie then
			cur:SetDie(fDie)
		end
		cur:SetPlayer(self, true)
		return cur
	else
		local ent = ents.Create("status_"..sType)
		if ent:IsValid() then
			ent:Spawn()
			if fDie then
				ent:SetDie(fDie)
			end
			ent:SetPlayer(self)
			return ent
		end
	end
end
