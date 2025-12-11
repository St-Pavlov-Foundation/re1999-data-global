module("modules.logic.survival.controller.work.step.SurvivalUnitShowWork", package.seeall)

local var_0_0 = class("SurvivalUnitShowWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = SurvivalMapModel.instance:getSceneMo()

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._stepMo.unit) do
		local var_1_2 = SurvivalUnitMo.New()

		var_1_2:init(iter_1_1)
		var_1_1:addUnit(var_1_2)

		var_1_0[var_1_2.id] = true
	end

	if (arg_1_0._stepMo.paramInt[1] or 0) == 1002 then
		if type(arg_1_1.tryTrigger) == "table" then
			for iter_1_2 in pairs(var_1_0) do
				arg_1_1.tryTrigger[iter_1_2] = true
			end
		else
			arg_1_1.tryTrigger = var_1_0
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0.getRunOrder(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1.haveHeroMove then
		arg_2_1.beforeFlow = FlowParallel.New()

		arg_2_2:addWork(arg_2_1.beforeFlow)

		arg_2_1.moveIdSet = {}
		arg_2_1.haveHeroMove = false
	end

	return SurvivalEnum.StepRunOrder.Before
end

return var_0_0
