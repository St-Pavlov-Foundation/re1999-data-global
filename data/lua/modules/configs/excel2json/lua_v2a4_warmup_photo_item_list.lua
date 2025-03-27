module("modules.configs.excel2json.lua_v2a4_warmup_photo_item_list", package.seeall)

slot1 = {
	imgName = 3,
	yes3 = 12,
	yes1 = 8,
	passTalkAllYes = 5,
	yes2 = 10,
	no2 = 11,
	preTalk = 4,
	passTalk = 6,
	failTalk = 7,
	no3 = 13,
	id = 1,
	no1 = 9,
	level = 2
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
