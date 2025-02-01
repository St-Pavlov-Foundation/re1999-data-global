module("modules.configs.excel2json.lua_soldier_chess", package.seeall)

slot1 = {
	cost = 8,
	name = 2,
	defaultPower = 6,
	type = 4,
	sell = 7,
	skillId = 12,
	resZoom = 11,
	formationDisplays = 3,
	resPic = 9,
	id = 1,
	resModel = 10,
	level = 5
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
