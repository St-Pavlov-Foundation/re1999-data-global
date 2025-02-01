module("modules.configs.excel2json.lua_activity145_movement", package.seeall)

slot1 = {
	displayTime = 5,
	type = 2,
	id = 1,
	motion = 3,
	content = 4
}
slot2 = {
	"id"
}
slot3 = {
	content = 2,
	motion = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
