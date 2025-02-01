module("modules.logic.explore.model.mo.unit.ExplorePipeMO", package.seeall)

slot0 = class("ExplorePipeMO", ExplorePipeBaseMO)

function slot0.initTypeData(slot0)
	slot0._pipeShape = tonumber(slot0.specialDatas[1])
	slot0._outDir = tonumber(slot0.specialDatas[2])
end

function slot0.isDivisive(slot0)
	return slot0._pipeShape == ExploreEnum.PipeShape.Shape3 or slot0._pipeShape == ExploreEnum.PipeShape.Shape4
end

function slot0.getPipeOutDir(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = ExploreHelper.getDir(slot1 - slot0.unitDir)

	if slot0._pipeShape == ExploreEnum.PipeShape.Shape1 then
		if slot2 == 0 or slot2 == 180 then
			return ExploreHelper.getDir(slot1 - 180)
		end
	elseif slot0._pipeShape == ExploreEnum.PipeShape.Shape2 then
		if slot2 == 0 then
			return ExploreHelper.getDir(slot1 + 90)
		elseif slot2 == 90 then
			return ExploreHelper.getDir(slot1 - 90)
		end
	elseif slot0._pipeShape == ExploreEnum.PipeShape.Shape3 then
		if (slot2 == 0 or slot2 == 90 or slot2 == 180) and slot0._outDir then
			if slot0._outDir == slot2 then
				return
			end

			return ExploreHelper.getDir(slot0._outDir + slot0.unitDir)
		end

		if slot2 == 0 then
			return ExploreHelper.getDir(slot1 + 90), ExploreHelper.getDir(slot1 + 180)
		elseif slot2 == 90 then
			return ExploreHelper.getDir(slot1 - 90), ExploreHelper.getDir(slot1 + 90)
		elseif slot2 == 180 then
			return ExploreHelper.getDir(slot1 - 90), ExploreHelper.getDir(slot1 - 180)
		end
	elseif slot0._pipeShape == ExploreEnum.PipeShape.Shape4 then
		if (slot2 == 0 or slot2 == 90 or slot2 == 180 or slot2 == 270) and slot0._outDir then
			if slot0._outDir == slot2 then
				return
			end

			return ExploreHelper.getDir(slot0._outDir + slot0.unitDir)
		end

		return ExploreHelper.getDir(slot1 + 90), ExploreHelper.getDir(slot1 + 180), ExploreHelper.getDir(slot1 + 270)
	elseif slot0._pipeShape == ExploreEnum.PipeShape.Shape5 then
		if slot2 == 0 then
			return ExploreHelper.getDir(slot1 + 90)
		elseif slot2 == 90 then
			return ExploreHelper.getDir(slot1 - 90)
		elseif slot2 == 180 then
			return ExploreHelper.getDir(slot1 + 90)
		elseif slot2 == 270 then
			return ExploreHelper.getDir(slot1 - 90)
		end
	elseif slot0._pipeShape == ExploreEnum.PipeShape.Shape6 and (slot2 == 0 or slot2 == 180 or slot2 == 90 or slot2 == 270) then
		return ExploreHelper.getDir(slot1 - 180)
	end
end

function slot0.isOutDir(slot0, slot1)
	slot2 = ExploreHelper.getDir(slot1 - slot0.unitDir)

	if slot0._pipeShape == ExploreEnum.PipeShape.Shape3 then
		if slot0._outDir then
			return slot0._outDir == slot2
		end

		return slot2 == 0 or slot2 == 90 or slot2 == 180
	elseif slot0._pipeShape == ExploreEnum.PipeShape.Shape4 then
		if slot0._outDir then
			return slot0._outDir == slot2
		end

		return slot2 == 0 or slot2 == 90 or slot2 == 180 or slot2 == 270
	end

	return false
end

function slot0.haveOutDir(slot0)
	return slot0._outDir and true or false
end

function slot0.getDirType(slot0, slot1)
	if slot0._pipeShape == ExploreEnum.PipeShape.Shape1 then
		if slot1 == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif slot1 == 180 and slot0:canRotate() then
			return ExploreEnum.PipeGoNode.Pipe2
		end
	elseif slot0._pipeShape == ExploreEnum.PipeShape.Shape2 then
		if slot1 == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif slot1 == 90 and slot0:canRotate() then
			return ExploreEnum.PipeGoNode.Pipe2
		end
	elseif slot0._pipeShape == ExploreEnum.PipeShape.Shape3 then
		if slot1 == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif slot1 == 90 then
			return ExploreEnum.PipeGoNode.Pipe2
		elseif slot1 == 180 then
			return ExploreEnum.PipeGoNode.Pipe3
		end
	elseif slot0._pipeShape == ExploreEnum.PipeShape.Shape4 then
		if slot1 == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif slot1 == 90 then
			return ExploreEnum.PipeGoNode.Pipe2
		elseif slot1 == 180 then
			return ExploreEnum.PipeGoNode.Pipe3
		elseif slot1 == 270 then
			return ExploreEnum.PipeGoNode.Pipe4
		end
	elseif slot0._pipeShape == ExploreEnum.PipeShape.Shape5 then
		if slot1 == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif slot1 == 180 then
			return ExploreEnum.PipeGoNode.Pipe2
		end
	elseif slot0._pipeShape == ExploreEnum.PipeShape.Shape6 then
		if slot1 == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif slot1 == 90 then
			return ExploreEnum.PipeGoNode.Pipe2
		end
	end
end

function slot0.getUnitClass(slot0)
	return ExplorePipeUnit
end

return slot0
