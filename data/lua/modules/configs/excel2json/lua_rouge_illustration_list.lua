module("modules.configs.excel2json.lua_rouge_illustration_list", package.seeall)

slot1 = {
	nameEn = 5,
	name = 4,
	eventId = 9,
	fullImage = 8,
	season = 1,
	image = 7,
	desc = 6,
	dlc = 10,
	id = 2,
	order = 3
}
slot2 = {
	"season",
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
