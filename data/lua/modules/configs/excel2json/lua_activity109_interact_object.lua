module("modules.configs.excel2json.lua_activity109_interact_object", package.seeall)

slot1 = {
	param = 6,
	name_en = 4,
	interactType = 5,
	name = 3,
	id = 2,
	avatar = 7,
	activityId = 1,
	showParam = 8
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
