module("modules.configs.excel2json.lua_fight_skin_dead_performance", package.seeall)

slot1 = {
	id = 1,
	actType5 = 10,
	actType1 = 2,
	actParam8 = 17,
	actParam5 = 11,
	actType2 = 4,
	actParam1 = 3,
	actType3 = 6,
	actType6 = 12,
	actParam6 = 13,
	actType4 = 8,
	actType7 = 14,
	actParam7 = 15,
	actParam2 = 5,
	actType8 = 16,
	actParam4 = 9,
	actParam3 = 7
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
