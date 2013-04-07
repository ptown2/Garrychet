GAMETYPE.Name = "Deathmatch"
GAMETYPE.Index = "dm"

GAMETYPE.RoundLimit = 3
GAMETYPE.FragLimit = 10
GAMETYPE.TimeLimit = 5 * 60


function GAMETYPE:OnThink()
	local self = GAMEMODE or GM

	if CurTime() >= TIMELIMIT and not self:IsRoundEnd() then
		local state = self:GetGamestate()

		if state == STATE_PLAYING then
			ValidFunction(GAMETYPES[self:GetGametype()], "ManageOvertime")
		end
	end
end

function GAMETYPE:OnPlayerInitSpawn(pl)
	pl:SetTeam(TEAM_DEATHMATCH)
end

function GAMETYPE:OnPlayerDeath(pl, attacker)
	if not IsValid(pl) or not IsValid(attacker) then return end
	if not attacker:IsPlayer() then return end

	local self = GAMEMODE or GM
	local frags = ValidVariable(GAMETYPES[self:GetGametype()], "FragLimit") or 0

	if attacker:Frags() >= frags and not ROUNDEND then
		self:EndRound()
		self:NotifyPlayers("The Round is over! The winner is ".. tostring(attacker:Nick()) .."! A new round starts in ".. WAIT_END .." seconds!")
	end
end

function GAMETYPE:ManageOvertime()
	local self = GAMEMODE or GM

	self:EndRound()
	self:NotifyPlayers("No-one has won. A new round starts in ".. WAIT_END .." seconds!")
end