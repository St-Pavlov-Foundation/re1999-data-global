module("modules.configs.excel2json.lua_bonus", package.seeall)

slot1 = {
	dailyGainLimit = 2,
	fixBonus = 6,
	score = 5,
	heroExp = 3,
	id = 1,
	bonusView = 7,
	dailyGainWarning = 8,
	playerExp = 4
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
