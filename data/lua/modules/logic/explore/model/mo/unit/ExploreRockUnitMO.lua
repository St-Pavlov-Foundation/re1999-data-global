module("modules.logic.explore.model.mo.unit.ExploreRockUnitMO", package.seeall)

slot0 = pureTable("ExploreRockUnitMO", ExploreBaseUnitMO)

function slot0.initTypeData(slot0)
	slot0.canTriggerGear = true
	slot0.triggerByClick = true
	slot0.preNodeKey = nil
	slot0.showRes = lua_explore_unit.configDict[ExploreEnum.ItemType.Rock].asset
	slot0.triggerEffects = {}

	table.insert(slot0.triggerEffects, {
		ExploreEnum.TriggerEvent.ItemUnit,
		""
	})
end

function slot0.getUnitClass(slot0)
	return ExploreRockUnit
end

function slot0.isInteractEnabled(slot0)
	return true
end

function slot0.isWalkable(slot0)
	return false
end

return slot0
