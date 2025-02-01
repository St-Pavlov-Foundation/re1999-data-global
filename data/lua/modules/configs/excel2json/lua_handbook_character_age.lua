module("modules.configs.excel2json.lua_handbook_character_age", package.seeall)

slot1 = {
	id = 1,
	image = 3,
	rewardIcon = 4,
	order = 2
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
