AddCSLuaFile()

ENT.Type = "point"
ENT.RespawnTime = 2

if SERVER then
	function ENT:Initialize()
		self.LastPowerup = 0
		self.CurPower = NULL
	end

	function ENT:Think()
		if not IsValid(self.CurPower) and (self.LastPowerup + self.RespawnTime) < CurTime() then
			local powerup = ents.Create("powerup_"..table.Random(POWERUPS))
			powerup:SetPos(self:GetPos())
			powerup:Spawn()
			powerup.Owner = self
			self.CurPower = powerup
		end
	end
end