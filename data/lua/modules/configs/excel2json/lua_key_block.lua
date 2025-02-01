module("modules.configs.excel2json.lua_key_block", package.seeall)

slot1 = {
	name = 2,
	hud = 1,
	blockkey = 3
}
slot2 = {
	"hud"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
