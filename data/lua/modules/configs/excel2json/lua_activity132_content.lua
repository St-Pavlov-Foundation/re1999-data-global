module("modules.configs.excel2json.lua_activity132_content", package.seeall)

slot1 = {
	content = 3,
	activityId = 1,
	contentId = 2,
	unlockDesc = 5,
	condition = 4
}
slot2 = {
	"activityId",
	"contentId"
}
slot3 = {
	content = 1,
	unlockDesc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
