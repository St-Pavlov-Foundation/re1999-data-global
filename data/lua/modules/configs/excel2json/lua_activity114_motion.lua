module("modules.configs.excel2json.lua_activity114_motion", package.seeall)

slot1 = {
	param = 3,
	face = 5,
	type = 2,
	id = 1,
	motion = 4
}
slot2 = {
	"id"
}
slot3 = {
	face = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
