module("modules.configs.excel2json.lua_activity117_talk", package.seeall)

slot1 = {
	content2 = 4,
	content1 = 3,
	activityId = 1,
	type = 2
}
slot2 = {
	"activityId",
	"type"
}
slot3 = {
	content2 = 2,
	content1 = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
