-- chunkname: @modules/logic/partygame/games/PedalingPlaidPartyGame.lua

module("modules.logic.partygame.games.PedalingPlaidPartyGame", package.seeall)

local PedalingPlaidPartyGame = class("PedalingPlaidPartyGame", PartyGameBase)

function PedalingPlaidPartyGame:getGameViewName()
	return ViewName.PedalingPlaidGameView
end

function PedalingPlaidPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	local score = PartyGameCSDefine.PedalingPlaidGameInterfaceCs.GetPlayerScore(uid)

	return score
end

return PedalingPlaidPartyGame
