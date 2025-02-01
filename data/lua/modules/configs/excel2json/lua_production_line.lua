module("modules.configs.excel2json.lua_production_line", package.seeall)

slot1 = {
	reserve = 5,
	name = 2,
	logic = 4,
	type = 3,
	id = 1,
	initFormula = 6,
	needRoomLevel = 8,
	levelGroup = 7
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
