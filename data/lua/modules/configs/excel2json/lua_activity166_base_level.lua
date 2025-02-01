module("modules.configs.excel2json.lua_activity166_base_level", package.seeall)

slot1 = {
	baseId = 2,
	firstBonus = 4,
	activityId = 1,
	level = 3
}
slot2 = {
	"activityId",
	"baseId",
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
