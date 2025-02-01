module("modules.logic.explore.model.mo.unit.ExploreObstacleMO", package.seeall)

slot0 = pureTable("ExploreObstacleMO", ExploreBaseUnitMO)

function slot0.initTypeData(slot0)
	slot0.triggerByClick = false
end

function slot0.getUnitClass(slot0)
	return ExploreBaseDisplayUnit
end

function slot0.isWalkable(slot0)
	return false
end

return slot0
