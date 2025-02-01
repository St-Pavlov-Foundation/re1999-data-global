module("modules.logic.explore.model.mo.unit.ExploreElevatorUnitMO", package.seeall)

slot0 = pureTable("ExploreElevatorUnitMO", ExploreBaseUnitMO)

function slot0.initTypeData(slot0)
	slot1 = string.splitToNumber(slot0.specialDatas[1], "#")
	slot0.height1 = slot1[1]
	slot0.height2 = slot1[2]
	slot2 = string.splitToNumber(slot0.specialDatas[2], "#")
	slot0.intervalTime = slot2[1]
	slot0.keepTime = slot2[2]
end

function slot0.getUnitClass(slot0)
	return ExploreElevatorUnit
end

function slot0.updateNodeHeight(slot0, slot1)
	for slot5 = slot0.offsetSize[1], slot0.offsetSize[3] do
		for slot9 = slot0.offsetSize[2], slot0.offsetSize[4] do
			ExploreMapModel.instance:updateNodeHeight(ExploreHelper.getKeyXY(slot0.nodePos.x + slot5, slot0.nodePos.y + slot9), slot1)
		end
	end
end

return slot0
