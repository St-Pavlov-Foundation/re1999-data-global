module("modules.configs.excel2json.lua_activity167_bubble", package.seeall)

slot1 = {
	interactId = 4,
	content = 6,
	id = 2,
	icon = 5,
	activityId = 1,
	step = 3
}
slot2 = {
	"activityId",
	"id",
	"step"
}
slot3 = {
	content = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
