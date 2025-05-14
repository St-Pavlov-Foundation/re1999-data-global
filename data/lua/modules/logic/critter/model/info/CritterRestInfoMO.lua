module("modules.logic.critter.model.info.CritterRestInfoMO", package.seeall)

local var_0_0 = pureTable("CritterRestInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.restBuildingUid = arg_1_1 and arg_1_1.buildingUid
	arg_1_0.seatSlotId = arg_1_1 and arg_1_1.restSlotId
end

return var_0_0
