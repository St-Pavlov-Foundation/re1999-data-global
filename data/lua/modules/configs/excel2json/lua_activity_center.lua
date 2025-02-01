module("modules.configs.excel2json.lua_activity_center", package.seeall)

slot1 = {
	sortPriority = 5,
	name = 2,
	id = 1,
	reddotid = 3,
	icon = 4
}
slot2 = {
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
