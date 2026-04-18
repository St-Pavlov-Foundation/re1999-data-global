-- chunkname: @modules/logic/partygame/games/PartyGameUtils.lua

module("modules.logic.partygame.games.PartyGameUtils", package.seeall)

local PartyGameUtils = class("PartyGameUtils")
local idToCls

function PartyGameUtils.getGameDefineClass(gameId)
	if not idToCls then
		idToCls = {}
	end

	local cls = idToCls[gameId] or PartyGameEnum.GameIdToName[gameId] and _G[string.format("%sPartyGame", PartyGameEnum.GameIdToName[gameId])]

	if not cls then
		cls = PartyGameBase

		logError("未定义 " .. gameId .. "的游戏类")
	end

	return cls.New()
end

return PartyGameUtils
