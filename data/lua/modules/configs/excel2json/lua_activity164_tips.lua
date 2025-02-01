module("modules.configs.excel2json.lua_activity164_tips", package.seeall)

slot1 = {
	id = 2,
	content = 3,
	activityId = 1
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	content = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
