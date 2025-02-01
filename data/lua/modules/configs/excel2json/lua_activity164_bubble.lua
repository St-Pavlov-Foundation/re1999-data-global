module("modules.configs.excel2json.lua_activity164_bubble", package.seeall)

slot1 = {
	id = 2,
	content = 4,
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
