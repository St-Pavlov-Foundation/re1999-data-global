module("modules.configs.excel2json.lua_backpack", package.seeall)

slot1 = {
	includecurrency = 5,
	name = 2,
	includeitem = 4,
	subname = 3,
	id = 1
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
