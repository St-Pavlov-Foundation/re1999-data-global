module("modules.configs.excel2json.lua_activity157_factory_component", package.seeall)

slot1 = {
	componentId = 2,
	preComponentId = 4,
	unlockCondition = 3,
	elementId = 6,
	nextComponentId = 5,
	bonusForShow = 8,
	bonusBuildingLevel = 9,
	activityId = 1,
	bonus = 7
}
slot2 = {
	"activityId",
	"componentId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
