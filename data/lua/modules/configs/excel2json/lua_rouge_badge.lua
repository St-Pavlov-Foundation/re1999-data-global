module("modules.configs.excel2json.lua_rouge_badge", package.seeall)

slot1 = {
	score = 8,
	name = 3,
	triggerParam = 7,
	id = 2,
	season = 1,
	icon = 5,
	trigger = 6,
	desc = 4
}
slot2 = {
	"season",
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
