module("modules.configs.excel2json.lua_rouge_last_reward", package.seeall)

slot1 = {
	id = 2,
	title = 5,
	iconName = 7,
	type = 4,
	season = 1,
	version = 3,
	desc = 6
}
slot2 = {
	"season",
	"id"
}
slot3 = {
	desc = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
