module("modules.configs.excel2json.lua_tower_boss", package.seeall)

slot1 = {
	bossId = 2,
	name = 3,
	nameEn = 4,
	towerId = 1
}
slot2 = {
	"towerId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
