module("modules.configs.excel2json.lua_act139_dispatch_task", package.seeall)

slot1 = {
	id = 1,
	desc = 9,
	time = 5,
	image = 10,
	title = 8,
	extraParam = 7,
	elementId = 11,
	shortType = 6,
	minCount = 3,
	maxCount = 4,
	activityId = 2
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
