module("modules.configs.excel2json.lua_stance", package.seeall)

slot1 = {
	pos8 = 9,
	pos1 = 2,
	subPos1 = 10,
	pos5 = 6,
	subPos2 = 11,
	subPos3 = 12,
	pos4 = 5,
	dec_stance = 13,
	pos3 = 4,
	cardCamera = 14,
	pos7 = 8,
	pos2 = 3,
	id = 1,
	pos6 = 7
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
