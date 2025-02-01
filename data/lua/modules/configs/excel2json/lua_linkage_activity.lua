module("modules.configs.excel2json.lua_linkage_activity", package.seeall)

slot1 = {
	item1 = 7,
	activityId = 1,
	showOnlineTime = 2,
	desc1 = 9,
	item2 = 8,
	showOfflineTime = 3,
	res_video2 = 5,
	desc2 = 10,
	res_video1 = 4,
	systemJumpCode = 6
}
slot2 = {
	"activityId"
}
slot3 = {
	desc2 = 2,
	desc1 = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
