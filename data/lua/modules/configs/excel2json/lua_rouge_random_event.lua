module("modules.configs.excel2json.lua_rouge_random_event", package.seeall)

slot1 = {
	id = 1,
	eventId = 2,
	relateId = 3
}
slot2 = {
	"id",
	"eventId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
