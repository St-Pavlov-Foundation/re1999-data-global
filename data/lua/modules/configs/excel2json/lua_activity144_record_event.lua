module("modules.configs.excel2json.lua_activity144_record_event", package.seeall)

slot1 = {
	eventIds = 5,
	name = 3,
	unLockDesc = 4,
	recordId = 2,
	activityId = 1
}
slot2 = {
	"activityId",
	"recordId"
}
slot3 = {
	unLockDesc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
