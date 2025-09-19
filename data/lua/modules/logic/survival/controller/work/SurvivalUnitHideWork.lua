module("modules.logic.survival.controller.work.SurvivalUnitHideWork", package.seeall)

local var_0_0 = class("SurvivalUnitHideWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalMapModel.instance:getSceneMo()
	local var_1_1

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._stepMo.paramInt) do
		if iter_1_0 == 1 then
			var_1_1 = iter_1_1
		else
			var_1_0:deleteUnit(iter_1_1, var_1_1 == 2003)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
