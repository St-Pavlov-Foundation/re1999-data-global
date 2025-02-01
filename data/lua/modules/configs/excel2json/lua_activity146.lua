module("modules.configs.excel2json.lua_activity146", package.seeall)

slot1 = {
	openDay = 4,
	name = 5,
	preId = 3,
	interactType = 9,
	text = 6,
	photo = 8,
	id = 2,
	activityId = 1,
	bonus = 7
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	text = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
