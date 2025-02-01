module("modules.configs.excel2json.lua_slow_release_gift", package.seeall)

slot1 = {
	onceBonus = 3,
	desc2 = 6,
	dailyBonus = 4,
	days = 2,
	id = 1,
	desc1 = 5
}
slot2 = {
	"id"
}
slot3 = {
	desc2 = 2,
	desc1 = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
