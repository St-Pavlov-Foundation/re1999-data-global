module("modules.logic.explore.model.mo.unit.ExplorePipeMemoryMO", package.seeall)

local var_0_0 = class("ExplorePipeMemoryMO", ExplorePipeBaseMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0._needColor = tonumber(arg_1_0.specialDatas[1])
	arg_1_0._pipeOutDir = tonumber(arg_1_0.specialDatas[2])
end

function var_0_0.setCacheColor(arg_2_0, arg_2_1)
	arg_2_0._cacheColor = arg_2_1
end

function var_0_0.getColor(arg_3_0, arg_3_1)
	if arg_3_1 == 0 then
		local var_3_0 = ExploreController.instance:getMapPipe()

		if var_3_0 and var_3_0:isInitDone() then
			local var_3_1 = ExploreHelper.dirToXY(arg_3_0.unitDir)
			local var_3_2 = ExploreHelper.getKeyXY(arg_3_0.nodePos.x + var_3_1.x, arg_3_0.nodePos.y + var_3_1.y)
			local var_3_3 = var_3_0._allPipeMos[var_3_2]

			return var_3_3 and var_3_0:getOutDirColor(nil, nil, ExploreHelper.getDir(arg_3_0.unitDir + 180), var_3_3.id, ExploreEnum.PipeDirMatchMode.Single) or ExploreEnum.PipeColor.None
		end
	end

	if not arg_3_0._cacheColor then
		arg_3_0._cacheColor = arg_3_0:getInteractInfoMO().statusInfo.color or ExploreEnum.PipeColor.None
	end

	return arg_3_0._cacheColor
end

function var_0_0.getPipeOutDir(arg_4_0)
	if not arg_4_0._pipeOutDir then
		return
	end

	return ExploreHelper.getDir(arg_4_0._pipeOutDir + arg_4_0.unitDir)
end

function var_0_0.isOutDir(arg_5_0, arg_5_1)
	return ExploreHelper.getDir(arg_5_1 - arg_5_0.unitDir) == arg_5_0._pipeOutDir
end

function var_0_0.getDirType(arg_6_0, arg_6_1)
	if arg_6_1 == 0 then
		return ExploreEnum.PipeGoNode.Pipe1
	elseif arg_6_1 == arg_6_0._pipeOutDir then
		return ExploreEnum.PipeGoNode.Pipe2
	end
end

function var_0_0.getNeedColor(arg_7_0)
	return arg_7_0._needColor
end

function var_0_0.getUnitClass(arg_8_0)
	return ExplorePipeMemoryUnit
end

return var_0_0
