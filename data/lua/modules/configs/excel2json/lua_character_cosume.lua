module("modules.configs.excel2json.lua_character_cosume", package.seeall)

slot1 = {
	cosume = 3,
	rare = 2,
	level = 1
}
slot2 = {
	"level",
	"rare"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
