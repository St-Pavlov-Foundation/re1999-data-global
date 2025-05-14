module("modules.logic.explore.model.mo.unit.ExplorePipePotMO", package.seeall)

local var_0_0 = class("ExplorePipePotMO", ExploreBaseUnitMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0.pipeColor = tonumber(arg_1_0.specialDatas[1])
end

function var_0_0.getBindPotId(arg_2_0)
	return arg_2_0:getInteractInfoMO().statusInfo.bindInteractId or 0
end

function var_0_0.getColor(arg_3_0)
	return arg_3_0.pipeColor
end

function var_0_0.getUnitClass(arg_4_0)
	return ExplorePipePotUnit
end

return var_0_0
