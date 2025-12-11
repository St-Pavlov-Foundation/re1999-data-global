module("modules.logic.survival.controller.work.step.SurvivalPlayFastBattleEffectWork", package.seeall)

local var_0_0 = class("SurvivalPlayFastBattleEffectWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalMapModel.instance:getSceneMo().unitsById[arg_1_0._stepMo.id]

	if var_1_0 then
		SurvivalMapHelper.instance:addPointEffect(var_1_0.pos, SurvivalPointEffectComp.ResPaths.fastfight)

		for iter_1_0, iter_1_1 in ipairs(var_1_0.exPoints) do
			SurvivalMapHelper.instance:addPointEffect(iter_1_1, SurvivalPointEffectComp.ResPaths.fastfight)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
