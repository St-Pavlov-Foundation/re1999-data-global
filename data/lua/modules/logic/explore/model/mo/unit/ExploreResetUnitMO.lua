module("modules.logic.explore.model.mo.unit.ExploreResetUnitMO", package.seeall)

slot0 = class("ExploreResetUnitMO", ExploreBaseUnitMO)

function slot0.initTypeData(slot0)
	slot0.targetX = string.splitToNumber(slot0.specialDatas[1], "#")[1] or 0
	slot0.targetY = slot1[2] or 0
	slot0.targetDir = slot1[3] or 0
end

return slot0
