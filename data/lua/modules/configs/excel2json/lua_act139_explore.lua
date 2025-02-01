module("modules.configs.excel2json.lua_act139_explore", package.seeall)

slot1 = {
	id = 1,
	desc = 8,
	time = 5,
	minCount = 3,
	maxCount = 4,
	title = 7,
	activityId = 2,
	extraParam = 6
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
