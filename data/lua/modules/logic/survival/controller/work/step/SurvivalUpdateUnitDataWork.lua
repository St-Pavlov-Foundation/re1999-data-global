module("modules.logic.survival.controller.work.step.SurvivalUpdateUnitDataWork", package.seeall)

local var_0_0 = class("SurvivalUpdateUnitDataWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalMapModel.instance:getSceneMo()

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._stepMo.unit) do
		local var_1_1 = var_1_0.unitsById[iter_1_1.id]

		if var_1_1 then
			local var_1_2 = var_1_1.cfgId
			local var_1_3 = var_1_1.pos

			var_1_1:init(iter_1_1)

			if var_1_3 ~= var_1_1.pos then
				local var_1_4 = var_1_1.pos

				var_1_1.pos = var_1_3

				var_1_0:onUnitUpdatePos(var_1_1, var_1_4)
			end

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitChange, var_1_1.id)

			if var_1_2 ~= var_1_1.cfgId then
				var_1_0:fixUnitExPos(var_1_1)
			end
		else
			var_1_1 = var_1_0.blocksById[iter_1_1.id]

			if var_1_1 then
				var_1_1:init(iter_1_1)

				if var_1_1:isDestory() then
					SurvivalHelper.instance:addNodeToDict(var_1_0.allDestroyPos, var_1_1.pos)

					for iter_1_2, iter_1_3 in ipairs(var_1_1.exPoints) do
						SurvivalHelper.instance:addNodeToDict(var_1_0.allDestroyPos, iter_1_3)
					end

					var_1_0:deleteUnit(var_1_1.id)
					SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapDestoryPosAdd, var_1_1)
				end
			end
		end

		if not var_1_1 then
			logError("元件不存在，更新失败" .. tostring(iter_1_1.id))
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0.getRunOrder(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = false

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._stepMo.unit) do
		if arg_2_1.moveIdSet[iter_2_1.id] then
			var_2_0 = true

			break
		end
	end

	if var_2_0 then
		arg_2_2:addWork(arg_2_0)

		return SurvivalEnum.StepRunOrder.None
	end

	return SurvivalEnum.StepRunOrder.Before
end

return var_0_0
