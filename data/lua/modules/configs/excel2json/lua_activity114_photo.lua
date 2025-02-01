module("modules.configs.excel2json.lua_activity114_photo", package.seeall)

slot1 = {
	name = 4,
	bigCg = 7,
	condition = 3,
	desc = 9,
	smallCg = 6,
	id = 2,
	features = 8,
	activityId = 1,
	nameEn = 5
}
slot2 = {
	"activityId",
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
