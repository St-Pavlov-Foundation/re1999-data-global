module("modules.configs.excel2json.lua_friendless", package.seeall)

slot1 = {
	friendliness = 2,
	percentage = 1
}
slot2 = {
	"percentage"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
