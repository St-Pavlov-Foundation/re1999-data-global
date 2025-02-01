module("modules.configs.excel2json.lua_rouge_collection_unlock", package.seeall)

slot1 = {
	typeSort = 3,
	unlockType = 5,
	sortId = 2,
	rareSort = 4,
	id = 1,
	unlockParam = 6
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
