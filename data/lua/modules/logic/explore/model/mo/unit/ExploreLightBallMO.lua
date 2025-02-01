module("modules.logic.explore.model.mo.unit.ExploreLightBallMO", package.seeall)

slot0 = class("ExploreLightBallMO", ExploreObstacleMO)

function slot0.initTypeData(slot0)
	slot0.triggerByClick = false
	slot0.showRes = lua_explore_unit.configDict[ExploreEnum.ItemType.LightBall].asset
	slot0.isPhotic = true
	slot0.triggerEffects = {}

	table.insert(slot0.triggerEffects, {
		ExploreEnum.TriggerEvent.ItemUnit,
		""
	})
end

function slot0.getUnitClass(slot0)
	return ExploreLightBallUnit
end

function slot0.isInteractEnabled(slot0)
	return true
end

return slot0
