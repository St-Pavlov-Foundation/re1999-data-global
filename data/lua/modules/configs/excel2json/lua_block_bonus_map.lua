module("modules.configs.excel2json.lua_block_bonus_map", package.seeall)

slot1 = {
	count = 1,
	bonus = 2
}
slot2 = {
	"count"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
