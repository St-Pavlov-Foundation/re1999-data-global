module("modules.configs.excel2json.lua_card_enchant", package.seeall)

slot1 = {
	feature = 7,
	id = 1,
	excludeTypes = 3,
	coverType = 2,
	rejectTypes = 4,
	stage = 5,
	desc = 8,
	decStage = 6
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
