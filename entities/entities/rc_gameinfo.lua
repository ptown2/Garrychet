ENT.Type = "point"

AccessorFunc(ENT, "m_GameType", "GameType")

function ENT:Initialize()
	if self:GetGameType() == nil then self:SetGameType(1) end
end

function ENT:KeyValue(key, value)
	key = string.lower(key)

	if key == "gametype" then
		self:SetGameType(tonumber(value or 1))
	end
end

function ENT:AcceptInput(name, activator, caller, args)
end
