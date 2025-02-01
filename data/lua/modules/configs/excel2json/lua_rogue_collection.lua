module("modules.configs.excel2json.lua_rogue_collection", package.seeall)

slot1 = {
	skills = 12,
	name = 2,
	group = 10,
	type = 3,
	eventGroupWeights = 17,
	dropGroupWeights = 19,
	unlockTask = 20,
	desc = 13,
	inHandBook = 21,
	statetype = 8,
	icon = 9,
	spdesc = 14,
	attr = 11,
	shopWeights = 18,
	holeNum = 6,
	showRare = 5,
	rare = 4,
	unique = 7,
	heartbeatRange = 15,
	eventWeights = 16,
	id = 1
}
slot2 = {
	"id"
}
slot3 = {
	name = 1,
	spdesc = 3,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
