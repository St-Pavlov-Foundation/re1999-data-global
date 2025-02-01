module("modules.configs.excel2json.lua_activity144_event", package.seeall)

slot1 = {
	eventId = 2,
	name = 6,
	eventType = 7,
	optionIds = 3,
	picture = 4,
	activityId = 1,
	desc = 5
}
slot2 = {
	"activityId",
	"eventId"
}
slot3 = {
	name = 2,
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
