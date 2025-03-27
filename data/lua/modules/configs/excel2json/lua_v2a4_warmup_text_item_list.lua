module("modules.configs.excel2json.lua_v2a4_warmup_text_item_list", package.seeall)

slot1 = {
	yes2 = 12,
	yes3 = 15,
	no3 = 16,
	info2 = 11,
	yes5 = 21,
	info4 = 17,
	yes6 = 24,
	yes4 = 18,
	passTalkAllYes = 5,
	info3 = 14,
	imgName = 3,
	no5 = 22,
	passTalk = 6,
	no4 = 19,
	no6 = 25,
	level = 2,
	yes1 = 9,
	no2 = 13,
	info5 = 20,
	preTalk = 4,
	failTalk = 7,
	info6 = 23,
	id = 1,
	info1 = 8,
	no1 = 10
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
