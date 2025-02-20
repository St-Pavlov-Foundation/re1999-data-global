module("modules.configs.excel2json.lua_activity174_turn", package.seeall)

slot1 = {
	groupNum = 7,
	name = 6,
	turn = 2,
	activityId = 1,
	endless = 9,
	shopLevel = 8,
	bag = 5,
	matchCoin = 11,
	point = 10,
	coin = 3,
	winCoin = 4
}
slot2 = {
	"activityId",
	"turn"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
