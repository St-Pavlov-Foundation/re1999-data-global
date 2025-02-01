module("modules.configs.excel2json.lua_polarization", package.seeall)

slot1 = {
	type = 2,
	name = 3,
	desc = 4,
	level = 1
}
slot2 = {
	"level",
	"type"
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
