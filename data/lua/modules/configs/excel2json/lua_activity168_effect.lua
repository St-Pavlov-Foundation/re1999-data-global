module("modules.configs.excel2json.lua_activity168_effect", package.seeall)

slot1 = {
	effectParams = 3,
	effectType = 2,
	desc = 4,
	effectId = 1
}
slot2 = {
	"effectId"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
