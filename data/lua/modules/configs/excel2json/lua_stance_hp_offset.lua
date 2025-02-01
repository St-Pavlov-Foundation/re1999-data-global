module("modules.configs.excel2json.lua_stance_hp_offset", package.seeall)

slot1 = {
	offsetPos8 = 9,
	offsetPos4 = 5,
	offsetPos1 = 2,
	offsetPos7 = 8,
	offsetPos3 = 4,
	id = 1,
	offsetPos5 = 6,
	offsetPos6 = 7,
	offsetPos2 = 3
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
