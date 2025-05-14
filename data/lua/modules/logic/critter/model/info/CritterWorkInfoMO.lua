module("modules.logic.critter.model.info.CritterWorkInfoMO", package.seeall)

local var_0_0 = pureTable("CritterWorkInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.workBuildingUid = arg_1_1 and arg_1_1.buildingUid
	arg_1_0.critterSlotId = arg_1_1 and arg_1_1.critterSlotId
end

function var_0_0.getBuildingInfo(arg_2_0)
	return arg_2_0.workBuildingUid, arg_2_0.critterSlotId
end

return var_0_0
