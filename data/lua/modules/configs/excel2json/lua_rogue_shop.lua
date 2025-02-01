module("modules.configs.excel2json.lua_rogue_shop", package.seeall)

slot1 = {
	desc = 2,
	pos13 = 15,
	pos12 = 14,
	pos5 = 7,
	pos1 = 3,
	pos8 = 10,
	pos4 = 6,
	pos14 = 16,
	pos15 = 17,
	pos6 = 8,
	pos10 = 12,
	pos16 = 18,
	pos9 = 11,
	pos11 = 13,
	pos3 = 5,
	pos7 = 9,
	pos2 = 4,
	id = 1
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
