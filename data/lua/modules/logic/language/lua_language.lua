module("modules.logic.language.lua_language", package.seeall)

slot1 = {
	content = 2,
	key = 1
}
slot2 = {
	"key"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
