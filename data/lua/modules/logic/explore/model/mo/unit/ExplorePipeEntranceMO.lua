module("modules.logic.explore.model.mo.unit.ExplorePipeEntranceMO", package.seeall)

slot0 = class("ExplorePipeEntranceMO", ExplorePipeBaseMO)

function slot0.initTypeData(slot0)
end

function slot0.getBindPotId(slot0)
	return slot0:getInteractInfoMO().statusInfo.bindInteractId or 0
end

function slot0.getPipeOutDir(slot0)
	return slot0.unitDir
end

function slot0.isOutDir(slot0, slot1)
	return ExploreHelper.getDir(slot1 - slot0.unitDir) == 0
end

function slot0.getDirType(slot0, slot1)
	if slot1 == 0 then
		return ExploreEnum.PipeGoNode.Pipe1
	end
end

function slot0.getColor(slot0)
	if ExploreController.instance:getMap():getUnit(slot0:getBindPotId(), true) then
		return slot2.mo:getColor()
	end

	return ExploreEnum.PipeColor.None
end

function slot0.getUnitClass(slot0)
	return ExplorePipeEntranceUnit
end

return slot0
