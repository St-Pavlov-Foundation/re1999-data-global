module("modules.configs.excel2json.lua_rouge_map_skill", package.seeall)

slot1 = {
	icon = 9,
	stepCd = 5,
	middleLayerLimit = 10,
	desc = 8,
	effects = 7,
	coinCost = 4,
	id = 1,
	version = 2,
	powerCost = 3,
	useLimit = 6
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
