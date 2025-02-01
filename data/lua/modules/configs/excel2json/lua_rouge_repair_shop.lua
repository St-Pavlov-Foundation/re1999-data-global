module("modules.configs.excel2json.lua_rouge_repair_shop", package.seeall)

slot1 = {
	id = 2,
	upConsume = 5,
	collectionId = 3,
	consume = 4,
	season = 1
}
slot2 = {
	"season",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
