module("modules.configs.excel2json.lua_activity168_option", package.seeall)

slot1 = {
	activityId = 1,
	name = 3,
	costItems = 6,
	effectId = 5,
	mustDrop = 7,
	optionId = 2,
	desc = 4
}
slot2 = {
	"activityId",
	"optionId"
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
