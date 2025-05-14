module("modules.logic.critter.model.info.CritterTrainOptionInfoMO", package.seeall)

local var_0_0 = pureTable("CritterTrainOptionInfoMO")
local var_0_1 = {}

function var_0_0.ctor(arg_1_0)
	arg_1_0.optionId = 0
	arg_1_0.addAttriButes = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or var_0_1
	arg_2_0.optionId = arg_2_1.optionId or 0
	arg_2_0.addAttriButes = CritterHelper.getInitClassMOList(arg_2_1.addAttributes, CritterAttributeInfoMO, arg_2_0.addAttriButes)
end

function var_0_0.getAddAttriuteInfoById(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.addAttriButes) do
		if iter_3_1.attributeId == arg_3_1 then
			return iter_3_1
		end
	end
end

return var_0_0
