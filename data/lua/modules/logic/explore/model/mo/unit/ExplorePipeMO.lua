module("modules.logic.explore.model.mo.unit.ExplorePipeMO", package.seeall)

local var_0_0 = class("ExplorePipeMO", ExplorePipeBaseMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0._pipeShape = tonumber(arg_1_0.specialDatas[1])
	arg_1_0._outDir = tonumber(arg_1_0.specialDatas[2])
end

function var_0_0.isDivisive(arg_2_0)
	return arg_2_0._pipeShape == ExploreEnum.PipeShape.Shape3 or arg_2_0._pipeShape == ExploreEnum.PipeShape.Shape4
end

function var_0_0.getPipeOutDir(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = ExploreHelper.getDir(arg_3_1 - arg_3_0.unitDir)

	if arg_3_0._pipeShape == ExploreEnum.PipeShape.Shape1 then
		if var_3_0 == 0 or var_3_0 == 180 then
			return ExploreHelper.getDir(arg_3_1 - 180)
		end
	elseif arg_3_0._pipeShape == ExploreEnum.PipeShape.Shape2 then
		if var_3_0 == 0 then
			return ExploreHelper.getDir(arg_3_1 + 90)
		elseif var_3_0 == 90 then
			return ExploreHelper.getDir(arg_3_1 - 90)
		end
	elseif arg_3_0._pipeShape == ExploreEnum.PipeShape.Shape3 then
		if (var_3_0 == 0 or var_3_0 == 90 or var_3_0 == 180) and arg_3_0._outDir then
			if arg_3_0._outDir == var_3_0 then
				return
			end

			return ExploreHelper.getDir(arg_3_0._outDir + arg_3_0.unitDir)
		end

		if var_3_0 == 0 then
			return ExploreHelper.getDir(arg_3_1 + 90), ExploreHelper.getDir(arg_3_1 + 180)
		elseif var_3_0 == 90 then
			return ExploreHelper.getDir(arg_3_1 - 90), ExploreHelper.getDir(arg_3_1 + 90)
		elseif var_3_0 == 180 then
			return ExploreHelper.getDir(arg_3_1 - 90), ExploreHelper.getDir(arg_3_1 - 180)
		end
	elseif arg_3_0._pipeShape == ExploreEnum.PipeShape.Shape4 then
		if (var_3_0 == 0 or var_3_0 == 90 or var_3_0 == 180 or var_3_0 == 270) and arg_3_0._outDir then
			if arg_3_0._outDir == var_3_0 then
				return
			end

			return ExploreHelper.getDir(arg_3_0._outDir + arg_3_0.unitDir)
		end

		return ExploreHelper.getDir(arg_3_1 + 90), ExploreHelper.getDir(arg_3_1 + 180), ExploreHelper.getDir(arg_3_1 + 270)
	elseif arg_3_0._pipeShape == ExploreEnum.PipeShape.Shape5 then
		if var_3_0 == 0 then
			return ExploreHelper.getDir(arg_3_1 + 90)
		elseif var_3_0 == 90 then
			return ExploreHelper.getDir(arg_3_1 - 90)
		elseif var_3_0 == 180 then
			return ExploreHelper.getDir(arg_3_1 + 90)
		elseif var_3_0 == 270 then
			return ExploreHelper.getDir(arg_3_1 - 90)
		end
	elseif arg_3_0._pipeShape == ExploreEnum.PipeShape.Shape6 and (var_3_0 == 0 or var_3_0 == 180 or var_3_0 == 90 or var_3_0 == 270) then
		return ExploreHelper.getDir(arg_3_1 - 180)
	end
end

function var_0_0.isOutDir(arg_4_0, arg_4_1)
	local var_4_0 = ExploreHelper.getDir(arg_4_1 - arg_4_0.unitDir)

	if arg_4_0._pipeShape == ExploreEnum.PipeShape.Shape3 then
		if arg_4_0._outDir then
			return arg_4_0._outDir == var_4_0
		end

		return var_4_0 == 0 or var_4_0 == 90 or var_4_0 == 180
	elseif arg_4_0._pipeShape == ExploreEnum.PipeShape.Shape4 then
		if arg_4_0._outDir then
			return arg_4_0._outDir == var_4_0
		end

		return var_4_0 == 0 or var_4_0 == 90 or var_4_0 == 180 or var_4_0 == 270
	end

	return false
end

function var_0_0.haveOutDir(arg_5_0)
	return arg_5_0._outDir and true or false
end

function var_0_0.getDirType(arg_6_0, arg_6_1)
	if arg_6_0._pipeShape == ExploreEnum.PipeShape.Shape1 then
		if arg_6_1 == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif arg_6_1 == 180 and arg_6_0:canRotate() then
			return ExploreEnum.PipeGoNode.Pipe2
		end
	elseif arg_6_0._pipeShape == ExploreEnum.PipeShape.Shape2 then
		if arg_6_1 == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif arg_6_1 == 90 and arg_6_0:canRotate() then
			return ExploreEnum.PipeGoNode.Pipe2
		end
	elseif arg_6_0._pipeShape == ExploreEnum.PipeShape.Shape3 then
		if arg_6_1 == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif arg_6_1 == 90 then
			return ExploreEnum.PipeGoNode.Pipe2
		elseif arg_6_1 == 180 then
			return ExploreEnum.PipeGoNode.Pipe3
		end
	elseif arg_6_0._pipeShape == ExploreEnum.PipeShape.Shape4 then
		if arg_6_1 == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif arg_6_1 == 90 then
			return ExploreEnum.PipeGoNode.Pipe2
		elseif arg_6_1 == 180 then
			return ExploreEnum.PipeGoNode.Pipe3
		elseif arg_6_1 == 270 then
			return ExploreEnum.PipeGoNode.Pipe4
		end
	elseif arg_6_0._pipeShape == ExploreEnum.PipeShape.Shape5 then
		if arg_6_1 == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif arg_6_1 == 180 then
			return ExploreEnum.PipeGoNode.Pipe2
		end
	elseif arg_6_0._pipeShape == ExploreEnum.PipeShape.Shape6 then
		if arg_6_1 == 0 then
			return ExploreEnum.PipeGoNode.Pipe1
		elseif arg_6_1 == 90 then
			return ExploreEnum.PipeGoNode.Pipe2
		end
	end
end

function var_0_0.getUnitClass(arg_7_0)
	return ExplorePipeUnit
end

return var_0_0
