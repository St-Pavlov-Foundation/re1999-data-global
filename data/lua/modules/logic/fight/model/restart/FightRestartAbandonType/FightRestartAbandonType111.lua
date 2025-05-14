module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType111", package.seeall)

local var_0_0 = class("FightRestartAbandonType111", FightRestartAbandonType1)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()

	arg_1_0._fight_work = arg_1_1
	arg_1_0._fightParam = arg_1_2
	arg_1_0._episode_config = arg_1_3
	arg_1_0._chapter_config = arg_1_4
end

function var_0_0.canRestart(arg_2_0)
	local var_2_0 = ActivityModel.instance:getActivityInfo()[VersionActivityEnum.ActivityId.Act113]

	if not var_2_0:isOnline() or not var_2_0:isOpen() or var_2_0:isExpired() then
		return false
	end

	return var_0_0.super.canRestart(arg_2_0)
end

return var_0_0
