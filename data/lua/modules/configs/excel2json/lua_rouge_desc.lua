module("modules.configs.excel2json.lua_rouge_desc", package.seeall)

slot1 = {
	descExtra = 6,
	name = 2,
	descType = 5,
	effectId = 3,
	id = 1,
	descSimply = 7,
	descExtraSimply = 8,
	desc = 4
}
slot2 = {
	"id",
	"effectId"
}
slot3 = {
	descExtra = 3,
	descSimply = 4,
	name = 1,
	descExtraSimply = 5,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
