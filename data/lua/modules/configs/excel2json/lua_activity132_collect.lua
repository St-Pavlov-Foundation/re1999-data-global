module("modules.configs.excel2json.lua_activity132_collect", package.seeall)

slot1 = {
	nameEn = 6,
	name = 3,
	collectId = 2,
	bg = 4,
	activityId = 1,
	clues = 5
}
slot2 = {
	"activityId",
	"collectId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
