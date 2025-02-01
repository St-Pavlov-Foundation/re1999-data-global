module("modules.logic.explore.model.mo.unit.ExploreGravityGearUnitMO", package.seeall)

slot0 = pureTable("ExploreGravityGearUnitMO", ExploreBaseUnitMO)

function slot0.initTypeData(slot0)
	slot0.keyUnitTypes = string.splitToNumber(slot0.specialDatas[1], "#")
	slot0.enterTriggerType = true
end

function slot0.getUnitClass(slot0)
	return ExploreGravityTriggerUnit
end

return slot0
