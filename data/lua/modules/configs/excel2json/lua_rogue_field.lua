module("modules.configs.excel2json.lua_rogue_field", package.seeall)

slot1 = {
	cost = 2,
	equipLevel = 6,
	level6 = 5,
	level4 = 3,
	level5 = 4,
	talentLevel = 7,
	level = 1
}
slot2 = {
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
