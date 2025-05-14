module("modules.logic.backpack.model.MaterialDataMO", package.seeall)

local var_0_0 = pureTable("MaterialDataMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.materilType = nil
	arg_1_0.materilId = nil
	arg_1_0.quantity = nil
	arg_1_0.uid = nil
	arg_1_0.roomBuildingLevel = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.materilType = arg_2_1.materilType
	arg_2_0.materilId = arg_2_1.materilId
	arg_2_0.quantity = arg_2_1.quantity
	arg_2_0.uid = arg_2_1.uid
	arg_2_0.roomBuildingLevel = arg_2_1.roomBuildingLevel
end

function var_0_0.initValue(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0.materilType = arg_3_1
	arg_3_0.materilId = arg_3_2
	arg_3_0.quantity = arg_3_3
	arg_3_0.uid = arg_3_4
	arg_3_0.roomBuildingLevel = arg_3_5
end

return var_0_0
