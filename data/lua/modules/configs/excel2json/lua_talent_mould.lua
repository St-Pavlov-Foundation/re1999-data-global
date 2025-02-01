module("modules.configs.excel2json.lua_talent_mould", package.seeall)

slot1 = {
	type11 = 5,
	type19 = 13,
	talentMould = 2,
	type14 = 8,
	type12 = 6,
	type17 = 11,
	type15 = 9,
	type20 = 14,
	type10 = 4,
	type13 = 7,
	type18 = 12,
	allShape = 3,
	talentId = 1,
	type16 = 10
}
slot2 = {
	"talentId",
	"talentMould"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
