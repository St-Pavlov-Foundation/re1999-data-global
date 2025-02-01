module("modules.configs.excel2json.lua_production_part", package.seeall)

slot1 = {
	productionLines = 4,
	name = 2,
	audio = 6,
	cameraParam = 5,
	id = 1,
	changeAudio = 7,
	nameEn = 3
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
