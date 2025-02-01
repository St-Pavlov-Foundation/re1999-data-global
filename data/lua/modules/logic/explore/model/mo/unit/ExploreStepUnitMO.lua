module("modules.logic.explore.model.mo.unit.ExploreStepUnitMO", package.seeall)

slot0 = pureTable("ExploreStepUnitMO", ExploreBaseUnitMO)

function slot0.initTypeData(slot0)
	slot0.enterTriggerType = true
end

function slot0.getUnitClass(slot0)
	return ExploreStepUnit
end

function slot0.isInActive(slot0)
	return slot0:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.ActiveState) == 1
end

return slot0
