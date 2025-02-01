module("modules.configs.excel2json.lua_fight_technique", package.seeall)

slot1 = {
	title_cn = 7,
	iconShow = 9,
	picture1 = 10,
	picture2 = 11,
	mainTitleId = 2,
	noDisplayType = 15,
	condition = 4,
	displayType = 14,
	isCn = 13,
	title_en = 8,
	mainTitle_en = 6,
	mainTitle_cn = 5,
	id = 1,
	content1 = 12,
	subTitleId = 3
}
slot2 = {
	"id"
}
slot3 = {
	title_cn = 3,
	content1 = 4,
	mainTitle_en = 2,
	mainTitle_cn = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
