module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType29", package.seeall)

local var_0_0 = class("FightRestartRequestType29", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()

	arg_1_0._fight_work = arg_1_1
end

function var_0_0.requestFight(arg_2_0)
	DungeonFightController.instance:restartStage()
	arg_2_0._fight_work:onDone(true)
end

function var_0_0.releaseSelf(arg_3_0)
	arg_3_0:__onDispose()
end

return var_0_0
