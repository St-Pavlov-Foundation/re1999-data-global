module("modules.configs.excel2json.lua_rouge_surprise_attack", package.seeall)

slot1 = {
	title = 2,
	hiddenRule = 4,
	ruleDesc = 5,
	tipsDesc = 6,
	id = 1,
	additionRule = 3
}
slot2 = {
	"id"
}
slot3 = {
	tipsDesc = 3,
	title = 1,
	ruleDesc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
