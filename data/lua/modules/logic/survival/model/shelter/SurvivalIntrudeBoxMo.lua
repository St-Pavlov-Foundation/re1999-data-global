module("modules.logic.survival.model.shelter.SurvivalIntrudeBoxMo", package.seeall)

local var_0_0 = pureTable("SurvivalIntrudeBoxMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.templateId = arg_1_1.templateId
	arg_1_0.fight = SurvivalIntrudeFightMo.New()

	arg_1_0.fight:init(arg_1_1.fight)
end

function var_0_0.getNextBossCreateDay(arg_2_0, arg_2_1)
	return SurvivalShelterModel.instance:getWeekInfo():getMonsterFight().beginTime
end

return var_0_0
