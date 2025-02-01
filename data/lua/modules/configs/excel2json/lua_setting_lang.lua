module("modules.configs.excel2json.lua_setting_lang", package.seeall)

slot1 = {
	fontasset2 = 4,
	lang = 2,
	textfontasset1 = 5,
	textfontasset2 = 6,
	shortcuts = 1,
	fontasset1 = 3
}
slot2 = {
	"shortcuts"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
