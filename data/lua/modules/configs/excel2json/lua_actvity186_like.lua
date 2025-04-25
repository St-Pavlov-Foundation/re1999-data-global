module("modules.configs.excel2json.lua_actvity186_like", package.seeall)

slot1 = {
	nameen = 4,
	name = 3,
	basevalueornot = 6,
	type = 1,
	icon = 5,
	activityId = 2
}
slot2 = {
	"type"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
