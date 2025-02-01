module("modules.configs.excel2json.lua_skill_eff_desc", package.seeall)

slot1 = {
	id = 1,
	name = 2,
	notAddLink = 4,
	isSpecialCharacter = 5,
	color = 3,
	desc = 6
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
