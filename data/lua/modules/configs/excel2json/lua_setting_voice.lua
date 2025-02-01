module("modules.configs.excel2json.lua_setting_voice", package.seeall)

slot1 = {
	shortcuts = 1,
	tips = 2
}
slot2 = {
	"shortcuts"
}
slot3 = {
	tips = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
