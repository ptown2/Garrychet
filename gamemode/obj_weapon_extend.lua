local meta = FindMetaTable("Weapon")
if not meta then return end

function meta:SetFireSpeed(speed)
	self.Primary.Delay = speed
end

function meta:ResetFireSpeed()
	self.Primary.Delay = 0.6
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

function meta:CheckPowerup(powerup)
	local owner = self.Owner
	local poweramt = owner:GetPowerupAmmo()
	
	owner:ReducePowerupAmmo()

	if poweramt <= 1 then
		self:ResetFireSpeed()
		owner:SetPowerup(POWERUP_NONE)
	end
end