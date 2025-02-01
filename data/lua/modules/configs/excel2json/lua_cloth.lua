module("modules.configs.excel2json.lua_cloth", package.seeall)

slot1 = {
	name = 2,
	skinId = 5,
	id = 1,
	icon = 4,
	enname = 3,
	desc = 6
}
slot2 = {
	"id"
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
