module("modules.configs.excel2json.lua_activity140_skill", package.seeall)

slot1 = {
	buildingId = 2,
	id = 1,
	ruleId = 3
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
