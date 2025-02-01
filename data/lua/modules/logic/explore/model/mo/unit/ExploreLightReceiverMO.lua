module("modules.logic.explore.model.mo.unit.ExploreLightReceiverMO", package.seeall)

slot0 = class("ExploreLightReceiverMO", ExploreBaseUnitMO)

function slot0.initTypeData(slot0)
	slot0.isPhoticDir = tonumber(slot0.specialDatas[1]) == 1
end

function slot0.getUnitClass(slot0)
	return ExploreLightReceiverUnit
end

return slot0
