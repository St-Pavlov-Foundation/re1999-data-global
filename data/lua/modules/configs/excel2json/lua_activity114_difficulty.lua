module("modules.configs.excel2json.lua_activity114_difficulty", package.seeall)

slot1 = {
	interval = 2,
	id = 1,
	word = 3
}
slot2 = {
	"id"
}
slot3 = {
	word = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
