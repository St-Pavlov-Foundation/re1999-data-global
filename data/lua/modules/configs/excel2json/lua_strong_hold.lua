module("modules.configs.excel2json.lua_strong_hold", package.seeall)

slot1 = {
	ruleId = 7,
	name = 2,
	eliminateBg = 3,
	id = 1,
	strongholdBg = 4,
	friendCapacity = 6,
	enemyCapacity = 5
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
