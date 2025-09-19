module("modules.logic.survival.controller.work.SurvivalUpdateUnitDataWork", package.seeall)

local var_0_0 = class("SurvivalUpdateUnitDataWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalMapModel.instance:getSceneMo()

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._stepMo.unit) do
		local var_1_1 = var_1_0.unitsById[iter_1_1.id]

		if not var_1_1 then
			logError("元件不存在，更新失败" .. tostring(iter_1_1.id))
		else
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
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
