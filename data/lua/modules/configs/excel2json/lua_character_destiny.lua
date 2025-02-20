module("modules.configs.excel2json.lua_character_destiny", package.seeall)

slot1 = {
	facetsId = 3,
	heroId = 1,
	slotsId = 2
}
slot2 = {
	"heroId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
