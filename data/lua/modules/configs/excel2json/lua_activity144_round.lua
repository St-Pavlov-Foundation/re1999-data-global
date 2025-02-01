module("modules.configs.excel2json.lua_activity144_round", package.seeall)

slot1 = {
	isPass = 4,
	keepMaterialRate = 6,
	round = 3,
	name = 7,
	actionPoint = 5,
	activityId = 1,
	episodeId = 2
}
slot2 = {
	"activityId",
	"episodeId",
	"round"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
