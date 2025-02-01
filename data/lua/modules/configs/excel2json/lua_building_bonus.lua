module("modules.configs.excel2json.lua_building_bonus", package.seeall)

slot1 = {
	bonus = 2,
	characterLimitAdd = 3,
	buildDegree = 1
}
slot2 = {
	"buildDegree"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
