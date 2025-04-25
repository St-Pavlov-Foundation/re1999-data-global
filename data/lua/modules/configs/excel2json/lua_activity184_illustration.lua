module("modules.configs.excel2json.lua_activity184_illustration", package.seeall)

slot1 = {
	imageId = 5,
	id = 2,
	shape = 4,
	activityId = 1,
	attribute = 3
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
