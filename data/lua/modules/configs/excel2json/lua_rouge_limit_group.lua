module("modules.configs.excel2json.lua_rouge_limit_group", package.seeall)

slot1 = {
	version = 2,
	unlockCondition = 5,
	icon = 6,
	id = 1,
	title = 3,
	desc = 4
}
slot2 = {
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
