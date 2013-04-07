-- Rounds --
function GM:NewRound()
	SetGlobalInt("rc_round", self:GetRound() + 1)
end
function GM:SetRound(round)
	SetGlobalInt("rc_round", round)
end
function GM:GetRound()
	return GetGlobalInt("rc_round")
end

-- Gametype --
function GM:SetGametype(gmtype)
	SetGlobalString("rc_gametype", gmtype)
end
function GM:GetGametype()
	return GetGlobalString("rc_gametype")
end

-- Gamestates --
function GM:SetGamestate(state)
	SetGlobalInt("rc_gamestate", state)
end
function GM:GetGamestate()
	return GetGlobalInt("rc_gamestate")
end

-- Time --
function GM:AddTime(time)
	SetGlobalInt("rc_timelimit", CurTime() + time)
	TIMELIMIT = self:GetTime()
end
function GM:GetTime()
	return GetGlobalInt("rc_timelimit")
end

-- Rounds --
function GM:EndRound()
	self:SetGamestate(STATE_ENDING)
	self:AddTime(WAIT_END)

	SetGlobalBool("rc_roundend", true)
	ROUNDEND = self:IsRoundEnd()
end
function GM:StartRound()
	local endtime = ValidVariable(GAMETYPES[self:GetGametype()], "TimeLimit") or 0

	self:SetGamestate(STATE_PLAYING)
	self:AddTime(endtime)
	self:NewRound()

	SetGlobalBool("rc_roundend", false)
	ROUND = self:GetRound()
	ROUNDEND = self:IsRoundEnd()
end
function GM:IsRoundEnd()
	return GetGlobalBool("rc_roundend")
end