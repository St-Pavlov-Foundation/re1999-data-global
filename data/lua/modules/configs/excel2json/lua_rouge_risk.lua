module("modules.configs.excel2json.lua_rouge_risk", package.seeall)

slot1 = {
	buffNum = 7,
	range = 4,
	scoreReward = 8,
	title = 2,
	content = 6,
	desc = 5,
	title_en = 3,
	id = 1,
	viewDown = 10,
	attr = 9
}
slot2 = {
	"id"
}
slot3 = {
	title_en = 2,
	title = 1,
	content = 4,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
