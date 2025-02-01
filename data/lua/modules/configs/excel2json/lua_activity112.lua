module("modules.configs.excel2json.lua_activity112", package.seeall)

slot1 = {
	items = 3,
	theme2 = 12,
	themeDone2 = 14,
	theme = 11,
	themeDone = 13,
	skin = 6,
	skinOffSet = 7,
	chatheadsOffSet = 10,
	head = 5,
	storyId = 15,
	skin2OffSet = 9,
	skin2 = 8,
	id = 2,
	activityId = 1,
	bonus = 4
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	themeDone = 3,
	themeDone2 = 4,
	theme2 = 2,
	theme = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
