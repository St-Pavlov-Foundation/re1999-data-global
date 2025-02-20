module("modules.configs.excel2json.lua_month_card_added", package.seeall)

slot1 = {
	onceBonus = 3,
	limit = 5,
	overMaxDayBonus = 6,
	days = 4,
	id = 1,
	month_id = 2
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
