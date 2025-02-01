module("modules.configs.excel2json.lua_luckybag_summon_character", package.seeall)

slot1 = {
	id = 1,
	heroId = 2,
	location = 4,
	skinId = 3
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
