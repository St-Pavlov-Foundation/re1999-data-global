module("modules.logic.versionactivity2_4.pinball.model.PinballMapCo", package.seeall)

local var_0_0 = pureTable("PinballMapCo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.units = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		arg_1_0.units[iter_1_0] = PinballUnitCo.New()

		arg_1_0.units[iter_1_0]:init(iter_1_1)
	end
end

return var_0_0
