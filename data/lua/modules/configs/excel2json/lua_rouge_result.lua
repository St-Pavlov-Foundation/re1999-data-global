module("modules.configs.excel2json.lua_rouge_result", package.seeall)

slot1 = {
	id = 2,
	priority = 5,
	triggerParam = 7,
	type = 3,
	season = 1,
	trigger = 6,
	desc = 4
}
slot2 = {
	"season",
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
