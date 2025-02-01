module("modules.logic.explore.model.mo.unit.ExplorePipeMemoryMO", package.seeall)

slot0 = class("ExplorePipeMemoryMO", ExplorePipeBaseMO)

function slot0.initTypeData(slot0)
	slot0._needColor = tonumber(slot0.specialDatas[1])
	slot0._pipeOutDir = tonumber(slot0.specialDatas[2])
end

function slot0.setCacheColor(slot0, slot1)
	slot0._cacheColor = slot1
end

function slot0.getColor(slot0, slot1)
	if slot1 == 0 and ExploreController.instance:getMapPipe() and slot2:isInitDone() then
		slot3 = ExploreHelper.dirToXY(slot0.unitDir)

		return slot2._allPipeMos[ExploreHelper.getKeyXY(slot0.nodePos.x + slot3.x, slot0.nodePos.y + slot3.y)] and slot2:getOutDirColor(nil, , ExploreHelper.getDir(slot0.unitDir + 180), slot5.id, ExploreEnum.PipeDirMatchMode.Single) or ExploreEnum.PipeColor.None
	end

	if not slot0._cacheColor then
		slot0._cacheColor = slot0:getInteractInfoMO().statusInfo.color or ExploreEnum.PipeColor.None
	end

	return slot0._cacheColor
end

function slot0.getPipeOutDir(slot0)
	if not slot0._pipeOutDir then
		return
	end

	return ExploreHelper.getDir(slot0._pipeOutDir + slot0.unitDir)
end

function slot0.isOutDir(slot0, slot1)
	return ExploreHelper.getDir(slot1 - slot0.unitDir) == slot0._pipeOutDir
end

function slot0.getDirType(slot0, slot1)
	if slot1 == 0 then
		return ExploreEnum.PipeGoNode.Pipe1
	elseif slot1 == slot0._pipeOutDir then
		return ExploreEnum.PipeGoNode.Pipe2
	end
end

function slot0.getNeedColor(slot0)
	return slot0._needColor
end

function slot0.getUnitClass(slot0)
	return ExplorePipeMemoryUnit
end

return slot0
