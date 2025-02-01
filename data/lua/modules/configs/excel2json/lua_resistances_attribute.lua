module("modules.configs.excel2json.lua_resistances_attribute", package.seeall)

slot1 = {
	forbid = 7,
	sleep = 3,
	dizzy = 2,
	frozen = 5,
	petrified = 4,
	delExPointResilience = 14,
	delExPoint = 11,
	stressUp = 12,
	controlResilience = 13,
	charm = 10,
	stressUpResilience = 15,
	seal = 8,
	id = 1,
	disarm = 6,
	cantGetExskill = 9
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
