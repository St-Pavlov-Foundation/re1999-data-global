module("modules.configs.excel2json.lua_activity108_grade", package.seeall)

slot1 = {
	score = 3,
	mapId = 2,
	bonus = 5,
	id = 1,
	desc = 4
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
