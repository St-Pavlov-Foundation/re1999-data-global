module("modules.configs.excel2json.lua_activity168_event", package.seeall)

slot1 = {
	optionIds = 4,
	eventId = 2,
	activityId = 1,
	name = 3
}
slot2 = {
	"activityId",
	"eventId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
