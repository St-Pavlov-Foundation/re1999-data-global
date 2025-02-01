module("modules.configs.excel2json.lua_rogue_skill", package.seeall)

slot1 = {
	num = 2,
	desc = 6,
	skills = 5,
	id = 1,
	icon = 3,
	attr = 4
}
slot2 = {
	"id",
	"num"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
