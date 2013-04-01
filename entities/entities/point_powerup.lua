AddCSLuaFile()

ENT.Type = "point"
ENT.RespawnTime = 2
ENT.PowerUps = {
	"powerup_freeze",
	"powerup_fire",
	"powerup_powershot",
	"powerup_fast",
	"powerup_triple"
}

if not SERVER then return end

function ENT:Initialize()
	self.LastPowerup = 0
	self.CurPower = NULL
end

function ENT:Think()
	if not IsValid(self.CurPower) and (self.LastPowerup + self.RespawnTime) < CurTime() then
		local powerup = ents.Create(self.PowerUps[math.random(1, 4)])
		powerup:SetPos(self:GetPos())
		powerup:Spawn()
		powerup.Owner = self
		self.CurPower = powerup
	end
end