module("modules.configs.excel2json.lua_activity178_talk", package.seeall)

slot1 = {
	id = 2,
	pram = 4,
	activityId = 1,
	type = 3
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
