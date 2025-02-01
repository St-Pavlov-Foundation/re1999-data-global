module("modules.configs.excel2json.lua_activity120_tips", package.seeall)

slot1 = {
	id = 2,
	tips = 3,
	activityId = 1,
	audioId = 4
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	tips = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
