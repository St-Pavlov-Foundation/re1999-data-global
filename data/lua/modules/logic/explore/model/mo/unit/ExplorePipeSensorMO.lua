module("modules.logic.explore.model.mo.unit.ExplorePipeSensorMO", package.seeall)

local var_0_0 = class("ExplorePipeSensorMO", ExplorePipeBaseMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0._needColor = tonumber(arg_1_0.specialDatas[1])
	arg_1_0._pipeOutDir = tonumber(arg_1_0.specialDatas[2])
end

function var_0_0.getColor(arg_2_0, arg_2_1)
	if arg_2_1 == 0 then
		local var_2_0 = ExploreController.instance:getMapPipe()

		if var_2_0 and var_2_0:isInitDone() then
			local var_2_1 = ExploreHelper.dirToXY(arg_2_0.unitDir)
			local var_2_2 = ExploreHelper.getKeyXY(arg_2_0.nodePos.x + var_2_1.x, arg_2_0.nodePos.y + var_2_1.y)
			local var_2_3 = var_2_0._allPipeMos[var_2_2]

			return var_2_3 and var_2_0:getOutDirColor(nil, nil, ExploreHelper.getDir(arg_2_0.unitDir + 180), var_2_3.id, ExploreEnum.PipeDirMatchMode.Single) or ExploreEnum.PipeColor.None
		end
	end

	local var_2_4 = arg_2_0:isInteractActiveState()

	if not var_2_4 then
		local var_2_5 = ExploreController.instance:getMapPipe()

		if var_2_5 and var_2_5:isCacheActive(arg_2_0.id) then
			var_2_4 = true
		end
	end

	if var_2_4 then
		return arg_2_0._needColor
	else
		return ExploreEnum.PipeColor.None
	end
end

function var_0_0.getNeedColor(arg_3_0)
	return arg_3_0._needColor
end

function var_0_0.getDirType(arg_4_0, arg_4_1)
	if arg_4_1 == 0 then
		return ExploreEnum.PipeGoNode.Pipe1
	elseif arg_4_1 == arg_4_0._pipeOutDir then
		return ExploreEnum.PipeGoNode.Pipe2
	end
end

function var_0_0.getPipeOutDir(arg_5_0)
	if not arg_5_0._pipeOutDir then
		return
	end

	return ExploreHelper.getDir(arg_5_0._pipeOutDir + arg_5_0.unitDir)
end

function var_0_0.isOutDir(arg_6_0, arg_6_1)
	return ExploreHelper.getDir(arg_6_1 - arg_6_0.unitDir) == arg_6_0._pipeOutDir
end

function var_0_0.getUnitClass(arg_7_0)
	return ExplorePipeSensorUnit
end

return var_0_0
