module("modules.logic.survival.controller.work.step.SurvivalAddExBlockWork", package.seeall)

local var_0_0 = class("SurvivalAddExBlockWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalMapHelper.instance:getScene()

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0._stepMo.extraBlock) do
			var_1_0.block:addExBlock(iter_1_1)
		end
	end

	local var_1_1 = SurvivalMapModel.instance:getSceneMo()

	if var_1_1 then
		tabletool.addValues(var_1_1.extraBlock, arg_1_0._stepMo.extraBlock)
	end

	arg_1_0:onDone(true)
end

return var_0_0
