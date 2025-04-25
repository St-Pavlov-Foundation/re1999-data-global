module("modules.configs.excel2json.lua_fight_float_effect", package.seeall)

slot1 = {
	prefabPath = 2,
	priority = 5,
	endTime = 4,
	id = 1,
	startTime = 3
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
