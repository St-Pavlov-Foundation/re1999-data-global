module("modules.configs.excel2json.lua_key_name_replace", package.seeall)

slot1 = {
	replacedName = 2,
	name = 1
}
slot2 = {
	"name"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
