GAMETYPE.Name = "Team Deathmatch"
GAMETYPE.Index = "tdm"

GAMETYPE.RoundLimit = 3
GAMETYPE.FragLimit = 25
GAMETYPE.TimeLimit = 10 * 60

function GAMETYPE:OnPlayerInitSpawn(pl)
	local blueteam = team.NumPlayers(TEAM_BLUE)
	local redteam = team.NumPlayers(TEAM_RED)

	if blueteam > redteam then
		pl:SetTeam(TEAM_RED)
	elseif redteam > blueteam then
		pl:SetTeam(TEAM_BLUE)
	else
		local bluescore = team.GetScore(TEAM_BLUE)
		local redscore = team.GetScore(TEAM_RED)

		if bluescore > redscore then
			pl:SetTeam(TEAM_RED)
		elseif redscore > bluescore then
			pl:SetTeam(TEAM_BLUE)
		else
			pl:SetTeam(math.random(TEAM_BLUE,TEAM_RED))
		end
	end

	pl:SetColor(team.GetColor(pl:Team()))
end