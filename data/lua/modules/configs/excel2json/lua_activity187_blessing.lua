module("modules.configs.excel2json.lua_activity187_blessing", package.seeall)

slot1 = {
	lanternImg = 5,
	lanternImgBg = 6,
	blessing = 7,
	lanternRibbon = 4,
	lantern = 3,
	activityId = 1,
	bonus = 2
}
slot2 = {
	"activityId",
	"bonus"
}
slot3 = {
	blessing = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
