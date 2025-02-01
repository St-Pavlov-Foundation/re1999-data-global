module("modules.configs.excel2json.lua_trade_task", package.seeall)

slot1 = {
	sortId = 6,
	isOnline = 14,
	extraBonus = 12,
	speaker = 9,
	logtext = 10,
	icon = 11,
	listenerType = 3,
	desc = 2,
	listenerParam = 4,
	minType = 15,
	maxProgress = 5,
	jumpId = 13,
	id = 1,
	addRoomLog = 8,
	tradeLevel = 7
}
slot2 = {
	"id"
}
slot3 = {
	minType = 2,
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
