module("modules.configs.excel2json.lua_simple_polarization", package.seeall)

slot1 = {
	desc = 3,
	name = 2,
	level = 1
}
slot2 = {
	"level"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
