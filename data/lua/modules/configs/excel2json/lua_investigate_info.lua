module("modules.configs.excel2json.lua_investigate_info", package.seeall)

slot1 = {
	icon = 6,
	name = 5,
	conclusionDesc = 11,
	conclusionBg = 10,
	group = 3,
	unlockDesc = 7,
	episode = 2,
	desc = 8,
	clueNumber = 9,
	id = 1,
	entrance = 4
}
slot2 = {
	"id"
}
slot3 = {
	unlockDesc = 2,
	name = 1,
	conclusionDesc = 4,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
