module("modules.configs.excel2json.lua_talent_style", package.seeall)

slot1 = {
	replaceCube = 4,
	name = 5,
	tagicon = 6,
	tag = 7,
	talentMould = 1,
	styleId = 2,
	color = 8,
	level = 3
}
slot2 = {
	"talentMould",
	"styleId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
