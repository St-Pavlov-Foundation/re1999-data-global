module("modules.configs.excel2json.lua_talent_cube_shape", package.seeall)

slot1 = {
	id = 1,
	shape = 2,
	icon = 4,
	sort = 3
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
