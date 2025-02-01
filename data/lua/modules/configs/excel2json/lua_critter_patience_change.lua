module("modules.configs.excel2json.lua_critter_patience_change", package.seeall)

slot1 = {
	stepValue = 3,
	stepTime = 2,
	buildingType = 1
}
slot2 = {
	"buildingType"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
