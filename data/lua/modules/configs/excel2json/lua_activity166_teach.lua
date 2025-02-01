module("modules.configs.excel2json.lua_activity166_teach", package.seeall)

slot1 = {
	episodeId = 3,
	name = 5,
	desc = 6,
	strategy = 7,
	teachId = 1,
	firstBonus = 4,
	preTeachId = 2
}
slot2 = {
	"teachId"
}
slot3 = {
	strategy = 3,
	name = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
