module("modules.logic.prototest.model.ProtoTestCaseModel", package.seeall)

local var_0_0 = class("ProtoTestCaseModel", MixScrollModel)

function var_0_0.getInfoList(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0:getList()) do
		local var_1_1 = #iter_1_1.value
		local var_1_2 = 45 + var_1_1 * 27.5
		local var_1_3 = SLFramework.UGUI.MixCellInfo.New(var_1_1, var_1_2, var_1_2)

		table.insert(var_1_0, var_1_3)
	end

	return var_1_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
