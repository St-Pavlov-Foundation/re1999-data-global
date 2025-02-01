module("modules.logic.explore.model.mo.unit.ExplorePrismMO", package.seeall)

slot0 = class("ExplorePrismMO", ExploreBaseUnitMO)

function slot0.initTypeData(slot0)
	slot0.fixItemId = tonumber(slot0.specialDatas[1])
end

function slot0.getUnitClass(slot0)
	return ExplorePrismUnit
end

return slot0
