module("modules.configs.excel2json.lua_condition", package.seeall)

slot1 = {
	desc = 3,
	progress = 5,
	type = 2,
	id = 1,
	attr = 4
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
