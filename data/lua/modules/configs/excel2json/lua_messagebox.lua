module("modules.configs.excel2json.lua_messagebox", package.seeall)

slot1 = {
	id = 1,
	content = 2
}
slot2 = {
	"id"
}
slot3 = {
	content = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
