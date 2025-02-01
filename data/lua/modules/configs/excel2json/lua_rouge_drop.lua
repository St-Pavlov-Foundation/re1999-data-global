module("modules.configs.excel2json.lua_rouge_drop", package.seeall)

slot1 = {
	power = 4,
	enterBag = 9,
	notOwned = 10,
	exp = 5,
	drop = 8,
	talent = 3,
	selectCount = 6,
	coin = 2,
	id = 1,
	dropCount = 7
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
