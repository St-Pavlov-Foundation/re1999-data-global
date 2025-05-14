module("modules.logic.explore.model.mo.unit.ExploreElevatorUnitMO", package.seeall)

local var_0_0 = pureTable("ExploreElevatorUnitMO", ExploreBaseUnitMO)

function var_0_0.initTypeData(arg_1_0)
	local var_1_0 = string.splitToNumber(arg_1_0.specialDatas[1], "#")

	arg_1_0.height1 = var_1_0[1]
	arg_1_0.height2 = var_1_0[2]

	local var_1_1 = string.splitToNumber(arg_1_0.specialDatas[2], "#")

	arg_1_0.intervalTime = var_1_1[1]
	arg_1_0.keepTime = var_1_1[2]
end

function var_0_0.getUnitClass(arg_2_0)
	return ExploreElevatorUnit
end

function var_0_0.updateNodeHeight(arg_3_0, arg_3_1)
	for iter_3_0 = arg_3_0.offsetSize[1], arg_3_0.offsetSize[3] do
		for iter_3_1 = arg_3_0.offsetSize[2], arg_3_0.offsetSize[4] do
			local var_3_0 = ExploreHelper.getKeyXY(arg_3_0.nodePos.x + iter_3_0, arg_3_0.nodePos.y + iter_3_1)

			ExploreMapModel.instance:updateNodeHeight(var_3_0, arg_3_1)
		end
	end
end

return var_0_0
