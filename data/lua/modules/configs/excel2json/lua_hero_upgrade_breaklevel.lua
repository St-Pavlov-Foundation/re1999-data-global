module("modules.configs.excel2json.lua_hero_upgrade_breaklevel", package.seeall)

slot1 = {
	skillEx = 5,
	skillGroup1 = 3,
	id = 1,
	skillGroup2 = 4,
	skillLevel = 2
}
slot2 = {
	"id",
	"skillLevel"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
