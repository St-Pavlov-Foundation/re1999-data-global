module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType166", package.seeall)

local var_0_0 = class("FightRestartAbandonType166", FightRestartAbandonType1)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()

	arg_1_0._fight_work = arg_1_1
	arg_1_0._fightParam = arg_1_2
	arg_1_0._episode_config = arg_1_3
	arg_1_0._chapter_config = arg_1_4
end

function var_0_0.canRestart(arg_2_0)
	local var_2_0 = Season166Model.instance:getBattleContext().actId
	local var_2_1 = ActivityHelper.getActivityStatusAndToast(var_2_0) ~= ActivityEnum.ActivityStatus.Normal
	local var_2_2 = Season166Model.instance:getActInfo(var_2_0)

	if var_2_1 or not var_2_2 then
		return false
	end

	return var_0_0.super.canRestart(arg_2_0)
end

return var_0_0
