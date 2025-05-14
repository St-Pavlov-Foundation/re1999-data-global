module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType1", package.seeall)

local var_0_0 = class("FightRestartRequestType1", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()

	arg_1_0._fight_work = arg_1_1
	arg_1_0._fightParam = arg_1_2
	arg_1_0._episode_config = arg_1_3
	arg_1_0._chapter_config = arg_1_4
end

function var_0_0.requestFight(arg_2_0)
	arg_2_0._fight_work:onDone(true)
	DungeonFightController.instance:restartStage()
end

function var_0_0.releaseSelf(arg_3_0)
	arg_3_0:__onDispose()
end

return var_0_0
