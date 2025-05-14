module("modules.logic.explore.model.mo.unit.ExplorePipeEntranceMO", package.seeall)

local var_0_0 = class("ExplorePipeEntranceMO", ExplorePipeBaseMO)

function var_0_0.initTypeData(arg_1_0)
	return
end

function var_0_0.getBindPotId(arg_2_0)
	return arg_2_0:getInteractInfoMO().statusInfo.bindInteractId or 0
end

function var_0_0.getPipeOutDir(arg_3_0)
	return arg_3_0.unitDir
end

function var_0_0.isOutDir(arg_4_0, arg_4_1)
	return ExploreHelper.getDir(arg_4_1 - arg_4_0.unitDir) == 0
end

function var_0_0.getDirType(arg_5_0, arg_5_1)
	if arg_5_1 == 0 then
		return ExploreEnum.PipeGoNode.Pipe1
	end
end

function var_0_0.getColor(arg_6_0)
	local var_6_0 = arg_6_0:getBindPotId()
	local var_6_1 = ExploreController.instance:getMap():getUnit(var_6_0, true)

	if var_6_1 then
		return var_6_1.mo:getColor()
	end

	return ExploreEnum.PipeColor.None
end

function var_0_0.getUnitClass(arg_7_0)
	return ExplorePipeEntranceUnit
end

return var_0_0
