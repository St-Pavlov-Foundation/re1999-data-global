module("modules.configs.excel2json.lua_rouge_limit_unlock", package.seeall)

slot1 = {
	style = 4,
	unlockCost = 5,
	skillId = 3,
	id = 1,
	version = 2
}
slot2 = {
	"id",
	"version"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
