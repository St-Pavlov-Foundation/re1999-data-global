module("modules.logic.explore.model.mo.unit.ExploreDoorUnitMO", package.seeall)

slot0 = pureTable("ExploreDoorUnitMO", ExploreBaseUnitMO)

function slot0.getUnitClass(slot0)
	return ExploreDoor
end

function slot0.isWalkable(slot0)
	return slot0:isDoorOpen()
end

function slot0.initTypeData(slot0)
	slot0.isPreventItem = tonumber(slot0.specialDatas[1]) == 1
end

function slot0.updateWalkable(slot0)
	slot0:setNodeOpenKey(slot0:isWalkable())
end

function slot0.isDoorOpen(slot0)
	return slot0:isInteractActiveState()
end

return slot0
