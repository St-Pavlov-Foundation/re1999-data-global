module("modules.configs.excel2json.lua_rouge_middle_layer", package.seeall)

slot1 = {
	leavePosUnlockType = 10,
	name = 3,
	leavePosUnlockParam = 11,
	dayOrNight = 13,
	pointPos = 7,
	empty = 14,
	path = 12,
	pathPointPos = 8,
	pathSelect = 5,
	leavePos = 9,
	id = 1,
	version = 2,
	nextLayer = 4,
	mapRes = 6
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
