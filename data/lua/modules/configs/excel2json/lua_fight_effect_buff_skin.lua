module("modules.configs.excel2json.lua_fight_effect_buff_skin", package.seeall)

slot1 = {
	orEnemy = 2,
	effectHang = 4,
	buffId = 1,
	skinId = 3,
	delEffect = 7,
	triggerEffect = 6,
	effectPath = 5,
	audio = 8
}
slot2 = {
	"buffId",
	"orEnemy",
	"skinId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
