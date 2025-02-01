module("modules.logic.explore.model.mo.unit.ExplorePipePotMO", package.seeall)

slot0 = class("ExplorePipePotMO", ExploreBaseUnitMO)

function slot0.initTypeData(slot0)
	slot0.pipeColor = tonumber(slot0.specialDatas[1])
end

function slot0.getBindPotId(slot0)
	return slot0:getInteractInfoMO().statusInfo.bindInteractId or 0
end

function slot0.getColor(slot0)
	return slot0.pipeColor
end

function slot0.getUnitClass(slot0)
	return ExplorePipePotUnit
end

return slot0
