module("modules.configs.excel2json.lua_character_info", package.seeall)

slot1 = {
	id = 2,
	res = 3,
	dialogueId = 1,
	pos = 4
}
slot2 = {
	"dialogueId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
