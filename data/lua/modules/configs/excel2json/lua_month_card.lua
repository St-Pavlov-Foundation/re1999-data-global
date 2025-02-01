module("modules.configs.excel2json.lua_month_card", package.seeall)

slot1 = {
	onceBonus = 3,
	dailyBonus = 4,
	days = 2,
	id = 1,
	maxDaysLimit = 5,
	overMaxDayBonus = 6
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
