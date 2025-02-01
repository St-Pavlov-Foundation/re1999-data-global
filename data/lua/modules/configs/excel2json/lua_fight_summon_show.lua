module("modules.configs.excel2json.lua_fight_summon_show", package.seeall)

slot1 = {
	audioId = 6,
	effect = 3,
	ingoreEffect = 7,
	skinId = 1,
	effectHangPoint = 5,
	effectTime = 4,
	actionName = 2
}
slot2 = {
	"skinId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
