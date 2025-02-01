module("modules.configs.excel2json.lua_talent_scheme", package.seeall)

slot1 = {
	talentMould = 2,
	starMould = 3,
	talentId = 1,
	talenScheme = 4
}
slot2 = {
	"talentId",
	"talentMould",
	"starMould"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
