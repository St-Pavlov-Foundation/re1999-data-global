module("modules.configs.excel2json.lua_rouge_layer_difficulty", package.seeall)

slot1 = {
	stepAttr = 3,
	difficulty = 1,
	layer = 2
}
slot2 = {
	"difficulty",
	"layer"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
