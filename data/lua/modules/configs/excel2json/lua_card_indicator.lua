module("modules.configs.excel2json.lua_card_indicator", package.seeall)

slot1 = {
	defaultValue = 4,
	desc = 3,
	valueRange = 5,
	takeTypeParam1 = 7,
	takeTypeParam2 = 9,
	takeType3 = 10,
	takeTypeParam3 = 11,
	takeType1 = 6,
	id = 1,
	takeType2 = 8,
	identity = 2
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
