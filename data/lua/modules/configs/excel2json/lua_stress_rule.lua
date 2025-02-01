module("modules.configs.excel2json.lua_stress_rule", package.seeall)

slot1 = {
	param = 5,
	targetLimit = 4,
	type = 2,
	id = 1,
	isNoShow = 6,
	target = 3,
	desc = 7
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
