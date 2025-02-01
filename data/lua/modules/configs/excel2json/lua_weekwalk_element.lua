module("modules.configs.excel2json.lua_weekwalk_element", package.seeall)

slot1 = {
	isBoss = 7,
	smokeMaskOffset = 12,
	lightOffsetPos = 11,
	type = 2,
	disappearEffect = 17,
	skipFinish = 4,
	pos = 14,
	desc = 13,
	roundId = 5,
	param = 3,
	effect = 16,
	starOffsetPos = 10,
	tipOffsetPos = 15,
	res = 6,
	generalType = 9,
	id = 1,
	bonusGroup = 8
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
