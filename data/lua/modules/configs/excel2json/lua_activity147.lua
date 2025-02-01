module("modules.configs.excel2json.lua_activity147", package.seeall)

slot1 = {
	jumpId = 6,
	descList = 2,
	spineRes = 4,
	rewardList = 3,
	dialogs = 5,
	activityId = 1
}
slot2 = {
	"activityId"
}
slot3 = {
	descList = 1,
	dialogs = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
