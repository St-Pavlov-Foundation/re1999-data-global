module("modules.configs.excel2json.lua_tower_assist_boss_change", package.seeall)

slot1 = {
	bossId = 1,
	activeSkills = 5,
	passiveSkills = 6,
	skinId = 3,
	form = 2,
	coldTime = 4,
	replacePassiveSkills = 7,
	resMaxVal = 8
}
slot2 = {
	"bossId",
	"form"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
