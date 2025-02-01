module("modules.configs.excel2json.lua_activity168_item", package.seeall)

slot1 = {
	itemId = 2,
	name = 3,
	compostType = 5,
	type = 4,
	weight = 6,
	icon = 7,
	activityId = 1,
	desc = 8
}
slot2 = {
	"activityId",
	"itemId"
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
