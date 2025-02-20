module("modules.configs.excel2json.lua_tower_assist_attribute", package.seeall)

slot1 = {
	bossId = 1,
	criDmg = 5,
	hp = 6,
	cri = 4,
	attack = 3,
	teamLevel = 2
}
slot2 = {
	"bossId",
	"teamLevel"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
