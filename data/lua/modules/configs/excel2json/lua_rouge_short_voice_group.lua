module("modules.configs.excel2json.lua_rouge_short_voice_group", package.seeall)

slot1 = {
	triggerType = 2,
	id = 1,
	triggerParam = 3,
	rate = 4
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
