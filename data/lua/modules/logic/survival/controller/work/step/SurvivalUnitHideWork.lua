module("modules.logic.survival.controller.work.step.SurvivalUnitHideWork", package.seeall)

local var_0_0 = class("SurvivalUnitHideWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalMapModel.instance:getSceneMo()
	local var_1_1

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._stepMo.paramInt) do
		if iter_1_0 == 1 then
			var_1_1 = iter_1_1
		else
			if var_1_1 == SurvivalEnum.UnitDeadReason.DieByQuickItem then
				local var_1_2 = var_1_0.unitsById[iter_1_1]

				if var_1_2 then
					SurvivalMapHelper.instance:addPointEffect(var_1_2.pos)

					for iter_1_2, iter_1_3 in ipairs(var_1_2.exPoints) do
						SurvivalMapHelper.instance:addPointEffect(iter_1_3)
					end
				end
			end

			var_1_0:deleteUnit(iter_1_1, var_1_1 == SurvivalEnum.UnitDeadReason.PlayDieAnim)
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0.getRunOrder(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = false

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._stepMo.paramInt) do
		if iter_2_0 ~= 1 and arg_2_1.moveIdSet[iter_2_1] then
			var_2_0 = true

			break
		end
	end

	if var_2_0 then
		return SurvivalEnum.StepRunOrder.After
	else
		if arg_2_1.haveHeroMove then
			arg_2_1.beforeFlow = FlowParallel.New()

			arg_2_2:addWork(arg_2_1.beforeFlow)

			arg_2_1.moveIdSet = {}
			arg_2_1.haveHeroMove = false
		end

		return SurvivalEnum.StepRunOrder.Before
	end
end

return var_0_0
