module("modules.configs.excel2json.lua_activity1001_ext", package.seeall)

slot1 = {
	sort = 5,
	rewards = 4,
	id = 2,
	title = 6,
	activityId = 1,
	desc = 3
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	title = 2,
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
