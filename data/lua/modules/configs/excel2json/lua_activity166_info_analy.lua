module("modules.configs.excel2json.lua_activity166_info_analy", package.seeall)

slot1 = {
	content = 6,
	infoId = 2,
	consume = 4,
	stage = 3,
	activityId = 1,
	bonus = 5
}
slot2 = {
	"activityId",
	"infoId",
	"stage"
}
slot3 = {
	content = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
